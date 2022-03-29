from flask import render_template,session, request,redirect,url_for,flash
from shop import app,db,bcrypt
from .forms import RegistrationForm,LoginForm
from .models import User
from shop.products.models import Addproduct,Category,Brand
import hashlib
from sqlalchemy import text

@app.route('/admin')
def admin():
    products = Addproduct.query.all()
    return render_template('admin/index.html', title='Admin page',products=products)

@app.route('/brands')
def brands():
    brands = Brand.query.order_by(Brand.id.desc()).all()
    return render_template('admin/brand.html', title='brands',brands=brands)


@app.route('/categories')
def categories():
    categories = Category.query.order_by(Category.id.desc()).all()
    return render_template('admin/brand.html', title='categories',categories=categories)

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        hash_password = (hashlib.md5(form.password.data.encode())).hexdigest()
        #hash_password = bcrypt.generate_password_hash(form.password.data)
        user = User(name=form.name.data,username=form.username.data, email=form.email.data,
                    password=hash_password)
        db.session.add(user)
        flash(f'welcome {form.name.data} Thanks for registering','success')
        db.session.commit()
        return redirect(url_for('login'))
    return render_template('admin/register.html',title='Register user', form=form)


@app.route('/login', methods=['GET','POST'])
def login():
    form = LoginForm()
    
    if form.validate_on_submit():
        sql = f"SELECT user.username,user.password FROM user WHERE user.username == '{form.username.data}' AND (user.password == '{(hashlib.md5(form.password.data.encode())).hexdigest()}')"
        try:
            #user = db.session.execute(sql).first()
            user = db.session.execute(sql).fetchall()
        except:
            user = None
        #user = User.query.filter_by(username=form.username.data).first()
        ##if user and bcrypt.check_password_hash(user.password, form.password.data):
        #if user and (user.password == (hashlib.md5(form.password.data.encode())).hexdigest()):
        if user:
            session['username'] = form.username.data
            if len(user) == 1:
                flash(f'welcome {user[0].username} you are logedin now','success')
            else:
                flash(f'welcome {user} you are logedin now','success')
            #flash(f'welcome {user.username} you are logedin now','success')
            return redirect(url_for('admin'))
        else:
            flash(f'Wrong username or password', 'danger')
            return redirect(url_for('login'))
    return render_template('admin/login.html',title='Login page',form=form)

@app.route('/admin/restoredb')
def restore_db():
    with open("shop/test-restore.sql", "r") as sql:
        conn = db.engine.raw_connection()
        conn.executescript(sql.read())
        conn.close()
    return redirect(url_for('login'))