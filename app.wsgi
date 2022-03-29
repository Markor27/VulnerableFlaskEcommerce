import sys
sys.path.insert(0,'/var/www/html/flaskecommerce/')

#from run import fapp as application
#from werkzeug.debug import DebuggedApplication application = DebuggedApplication(app, True)
from werkzeug.debug import DebuggedApplication
from run import app as application
application = DebuggedApplication(application, True, pin_security = False)
