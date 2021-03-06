from flask import render_template,session, request,redirect,url_for,flash,current_app,make_response, send_file
from flask_login import login_required, current_user, logout_user, login_user
from shop import app,db,photos, search,bcrypt,login_manager
from .forms import CustomerRegisterForm, CustomerLoginFrom
from .model import Register,CustomerOrder
import secrets
import os
import json
import pdfkit
import stripe
import hashlib

from datetime import datetime
from sqlalchemy.sql import text

buplishable_key ="pk_test_51KK8w1FYw28uBQKVHuWZXIbfhFCvPmiNnGz0lRevRwQ2utxHPQoZfkPnCwPd5zT1Y6nUiHlU0g0nrbPsC5xahkm1006X8LG44a"
stripe.api_key = "sk_test_51KK8w1FYw28uBQKVw1kV3TCDh0K2RVF7cdJSWLkO5Dr2l7VxOSS0TtJxA3cfAliX7YnlLNVNqn627Ev9nxjmQDHO00axs1Jy7b"


@app.route('/payment',methods=['POST'])
def payment():
    invoice = request.form.get('invoice')
    amount = request.form.get('amount')
    customer = stripe.Customer.create(
      email=request.form['stripeEmail'],
      source=request.form['stripeToken'],
    )
    charge = stripe.Charge.create(
      customer=customer.id,
      description='Battle-Field Bargains',
      amount=amount,
      currency='gbp',
    )
    orders =  CustomerOrder.query.filter_by(customer_id = current_user.id,invoice=invoice).order_by(CustomerOrder.id.desc()).first()
    orders.status = 'Paid'
    
    db.session.commit()
    flash(f'Thank you for your payment!', 'success')
    #return redirect(url_for('thanks'))
    #time.sleep(5)
    return redirect(url_for('home'))

@app.route('/thanks')
def thanks():
    return render_template('customer/thank.html')
#@app.route('/static/images/<filename>')
#def images(filename):
#    return send_file('/var/www/html/flaskecommerce/shop/static/images/'+filename)


@app.route('/customer/register', methods=['GET','POST'])
def customer_register():
    """Easy Mode SQL Injection
    
    This will just execute as many queries as you throw at it providing
    they have the correct syntax.
    """

    form = CustomerRegisterForm()
    
    if form.validate_on_submit():
        profile_photo = photos.save(request.files.get('profile'))
        
        hash_password = (hashlib.md5(form.password.data.encode())).hexdigest()

        insert_query = u"""
        INSERT INTO register (
            name, 
            username, 
            email, 
            password, 
            country, 
            city, 
            contact, 
            address, 
            zipcode,
            profile,
            date_created
        ) VALUES (
            '{name}', 
            '{username}', 
            '{email}', 
            '{password}',
            '{country}', 
            '{city}', 
            '{contact}', 
            '{address}', 
            '{zipcode}', 
            '{profile}',
            datetime('now')
        );
        """.format(
            name=form.name.data, 
            username=form.username.data, 
            email=form.email.data,
            password=hash_password,
            country=form.country.data,
            city=form.city.data,
            contact=form.contact.data,
            address=form.address.data, 
            zipcode=form.zipcode.data,
            profile=profile_photo
        )

        conn = db.engine.raw_connection()
        conn.executescript(insert_query)
        conn.close()
        flash(f'Welcome {form.name.data} Thank you for registering', 'success')
        return redirect(url_for('customerLogin'))
    return render_template('customer/register.html', form=form)


@app.route('/customer/login', methods=['GET','POST'])
def customerLogin():
    """Customer Login with Medium Difficulty SQL Exploit

    This route has been rewritten to first hash the password
    and then look up the user table for a user matching the
    username and password. 
    This allows for an SQL injection vulnerability where the
    user enters e.g.

        email@domain.com';--

    bypassing the password check and logging into any user.

    However, this format only allows for the execution of a single
    SQL query so it cannot be used to execute arbitrary queries,
    only those which can be incorporated into a valid SELECT command.

    For an example of a query that can leak data this way:

        admin@site.com' UNION SELECT id, password, email, username, name, 
        country, city, contact, address, zipcode, profile, date_created 
        FROM register WHERE email='admin@site.com' ORDER BY name DESC;--

    Note how in the UNION SELECT, the place of `password` and `name` are
    swapped. This means that the table returned by the query will have
    the password hash in the name column and vice versa. In combination with
    the `.first()` returning the first row from the column and the 
    `ORDER BY name DESC`, password hash should appear first and be returned

    This allows for slow but automatable exfiltration of any database field 
    """
    form = CustomerLoginFrom()
    if form.validate_on_submit():
        email = form.email.data
        pw_hash = hashlib.md5(form.password.data.encode()).hexdigest() # bcrypt.generate_password_hash(form.password.data)
        query = text(
            "SELECT * FROM register WHERE email='{}' AND password='{}';".format(
                email,
                pw_hash
            )
        )

        try:
            user = Register.query.from_statement(query).first() #   .first() will return only first value, can be used to bypass the login however it won`t be possible to display the entire content of a table or more then one row 
        except:
            user = None
        if user:
            login_user(user)
            flash(
                'You are logged in as {}!'.format(user.name), 
                'success'
            )
            next = request.args.get('next')
            return redirect(next or url_for('home'))
        flash('Incorrect email and password','danger')
        return redirect(url_for('customerLogin'))
            
    return render_template('customer/login.html', form=form)


@app.route('/customer/logout')
def customer_logout():
    logout_user()
    return redirect(url_for('home'))

def updateshoppingcart():
    for key, shopping in session['Shoppingcart'].items():
        session.modified = True
        del shopping['image']
        del shopping['colors']
    return updateshoppingcart

@app.route('/getorder')
@login_required
def get_order():
    if current_user.is_authenticated:
        customer_id = current_user.id
        invoice = secrets.token_hex(5)
        updateshoppingcart
        try:
            order = CustomerOrder(invoice=invoice,customer_id=customer_id,orders=session['Shoppingcart'])
            db.session.add(order)
            db.session.commit()
            session.pop('Shoppingcart')
            flash('Your order has been sent successfully','success')
            return redirect(url_for('orders',invoice=invoice))
        except Exception as e:
            print(e)
            flash('Some thing went wrong while get order', 'danger')
            return redirect(url_for('getCart'))
        


@app.route('/orders/<invoice>')
@login_required
def orders(invoice):
    if current_user.is_authenticated:
        grandTotal = 0
        subTotal = 0
        customer_id = current_user.id
        customer = Register.query.filter_by(id=customer_id).first()
        orders = CustomerOrder.query.filter_by(customer_id=customer_id, invoice=invoice).order_by(CustomerOrder.id.desc()).first()
        for _key, product in orders.orders.items():
            discount = (product['discount']/100) * float(product['price'])
            subTotal += float(product['price']) * int(product['quantity'])
            subTotal -= discount
            tax = ("%.2f" % (.06 * float(subTotal)))
            grandTotal = ("%.2f" % (1.06 * float(subTotal)))

    else:
        return redirect(url_for('customerLogin'))
    return render_template('customer/order.html', invoice=invoice, tax=tax,subTotal=subTotal,grandTotal=grandTotal,customer=customer,orders=orders)




@app.route('/get_pdf/<invoice>', methods=['GET','POST'])
@login_required
def get_pdf(invoice):
    if current_user.is_authenticated:
        grandTotal = 0
        subTotal = 0
        customer_id = current_user.id
        if request.method =="POST" or request.method =="GET":
            customer = Register.query.filter_by(id=customer_id).first()
            orders = CustomerOrder.query.filter_by(customer_id=customer_id, invoice=invoice).order_by(CustomerOrder.id.desc()).first()
            for _key, product in orders.orders.items():
                discount = (product['discount']/100) * float(product['price'])
                subTotal += float(product['price']) * int(product['quantity'])
                subTotal -= discount
                tax = ("%.2f" % (.06 * float(subTotal)))
                grandTotal = float("%.2f" % (1.06 * subTotal))

            rendered =  render_template('customer/pdf.html', invoice=invoice, tax=tax,grandTotal=grandTotal,customer=customer,orders=orders)
            pdf = pdfkit.from_string(rendered, False)
            response = make_response(pdf)
            response.headers['content-Type'] ='application/pdf'
            response.headers['content-Disposition'] ='inline; filename='+invoice+'.pdf'
            return response
    return request(url_for('orders'))



