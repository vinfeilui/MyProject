from flask import Flask, render_template, flash, redirect, url_for, session, request, logging
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from functools import wraps

app = Flask(__name__)

# Configure MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '1111'
app.config['MYSQL_DB'] = 'bookstore'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# Initialize MYSQL
mysql = MySQL(app)

# Home page
@app.route('/')
def home():
    return render_template('home.html')

# About us
@app.route('/about-us')
def about_us():
    return render_template('about_us.html')

# Register Form Class
class RegisterForm(Form):
    # Wtforms
    name = StringField('Name', [validators.Length(min=4, max=50)])
    email = StringField('Email', [validators.Length(min=6, max=50)])
    address = StringField('Address', [validators.Length(min=6, max=50)])
    username = StringField('Username', [validators.Length(min=4, max=25)])
    password = PasswordField('Password', [
        validators.Length(min=4, max=25),
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Passwords do not match')
    ])
    confirm = PasswordField('Confirm Password')


# User Register
@app.route('/register', methods=['GET', 'POST'])
def register():

    # Instantiate object of RegisterForm
    form = RegisterForm(request.form)

    # Create cursor
    cur = mysql.connection.cursor()

    # Check if there is a same username
    result = cur.execute("SELECT * FROM users WHERE username = %s", [form.name.data])

    # Close connection
    cur.close()
    
    # If the username has been used  
    if request.method == 'POST' and form.validate() and result > 0:
        error = 'This username has been used. Please pick another one.'
        return render_template('register.html', form=form, error = error)

    # if the data is valid
    elif request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        address = form.address.data
        username = form.username.data
        password = form.password.data

        # Create cursor
        cur = mysql.connection.cursor()

        # Insert a new record to table 'users'
        cur.execute("INSERT INTO users(name, email, username, password, address) VALUES(%s, %s, %s, %s, %s)", (name, email, username, password, address))

        # Commit to DB
        mysql.connection.commit()

        # Close connection
        cur.close()

        # Flash the success message
        flash('You are now registered and can log in', 'success')

        # Do if the user successfully registered
        return redirect(url_for('login'))

    return render_template('register.html', form=form)


# User login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':

        # Get data from fields
        username = request.form['username']
        password_candidate = request.form['password']

        # Create cursor
        cur = mysql.connection.cursor()

        # Get a row of record by username
        result = cur.execute("SELECT * FROM users WHERE username = %s", [username])

        # If username is found
        if result > 0:

            # Get stored password matched to that username
            data = cur.fetchone()
            password = data['password']

            # Compare Passwords
            if password_candidate == password:
                
                # Passed 
                # Create session for user
                session['logged_in'] = True
                session['username'] = username

                # Create session particularlly to 'id' in table 'users'
                result = cur.execute("SELECT id FROM users WHERE username = %s", [username])
                id = cur.fetchone()
                id = id['id']
                session['id'] = id

                # Flash success message
                flash('You are now logged in', 'success')
                return redirect(url_for('home'))

            # If password is not matched    
            else:
                error = 'Invalid password'
                # Go back to login page
                return render_template('login.html', error=error)

            # Close connection
            cur.close()

        # If no username is found    
        else:
            error = 'Username not found'
            return render_template('login.html', error=error)

    return render_template('login.html')



# Check if user logged in
def is_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        # If user is logged in --> continue
        if 'logged_in' in session:
            return f(*args, **kwargs)
        # If user is logged out and want to go to some pages like shopping cart
        else:
            flash('Unauthorized, Please login', 'danger')
            return redirect(url_for('login'))
    return wrap


# Logout
@app.route('/logout')
@is_logged_in
def logout():
    # Clear the data in session
    session.clear()
    flash('You are now logged out', 'success')
    return redirect(url_for('login'))

# New arrivals
@app.route('/new-arrivals')
def new_arrivals():

    # Create cursor
    cur = mysql.connection.cursor()

    # Get all books with the latest on the top
    result = cur.execute("SELECT * FROM books ORDER BY import_date DESC")

    books = cur.fetchall()

    # Close connection
    cur.close()

    # If number of books > 0
    if result > 0:
        return render_template('new_arrivals.html', books=books)

    # If number of books = 0
    else:
        msg = 'No Books Found'
        return render_template('new_arrivals.html', msg=msg)


# Single Book Page
# Dynamic url
@app.route('/book/<string:id>/')
def book(id):

    # Create cursor
    cur = mysql.connection.cursor()

    # Get information of a book
    result = cur.execute("SELECT * FROM books WHERE id = %s", [id])

    book = cur.fetchone()

    # Close connection
    cur.close()

    return render_template('book.html', book=book)





# All books
# Dynamic url 
@app.route('/books/<string:page_no>')
def books(page_no):

    # Crate cursor
    cur = mysql.connection.cursor()

    # Count how many books are in database
    cur.execute("SELECT COUNT(*) FROM books")
    data = cur.fetchone()
    no_of_books = data
    no_of_books = data['COUNT(*)']

    # Calculate how many pages should be rendered
    if no_of_books % 4 == 0 :
        no_of_pages = no_of_books /4
    else:
        no_of_pages = no_of_books / 4 + 1


    # Store all book information in all_book_info
    # With [{},{},{}...{}]
    cur.execute('SELECT * FROM books')
    all_book_info = cur.fetchall()
    # Convert tuple to list to make it mutable
    # ({},{},{}...{})
    all_book_info = list(all_book_info)

    # Close connection
    cur.close()

    # Create a list for showing all book info
    show_list = []

    # If current page no is 1
    # Render first 4 item
    if page_no == 1:
        for one_to_four in range (0,4):
            # Include the exception in index error
            # If there is only 3 books, let the program continues to run
            try:
                j=all_book_info[k]
                show_list.append(j)
            except IndexError:
                break

    # If current page no is not = 1
    # Render first 4 item of that page
    else:
        temp_page = int(page_no) -1
        start_item = temp_page*4

    for k in range(0,4):
        try:
            j=all_book_info[start_item+k]
            show_list.append(j)
        except IndexError:
            break

    if no_of_books > 0 :
        category = 'books'
        # Pass all the variables to flask for rendering the layout
        return render_template('books.html',category=category,no_of_books=no_of_books,no_of_pages=no_of_pages,all_book_info=all_book_info,page_no=page_no,show_list=show_list)

    # If there is no books
    else:
        error = 'No Books Found'
        return render_template('home.html', error=error)



# Category of books
# Dynamic url
@app.route('/<string:category>/<string:page_no>')
def category(category,page_no):

    # Create cursor
	cur = mysql.connection.cursor()

	# Get books matched that category
	cur.execute('SELECT COUNT(*) FROM books WHERE category = "%s"' %category)
	data = cur.fetchone()
	no_of_books = data
	no_of_books = data['COUNT(*)']

    # Below is very similiar to /book/<page_no>
    # Calculate how many page to render
    # Calculate which item should start to render
	if no_of_books % 4 == 0 :
		no_of_pages = no_of_books /4
	else:
		no_of_pages = no_of_books / 4 + 1



	cur.execute('SELECT * FROM books WHERE category = "%s"' %category)
	all_book_info = cur.fetchall()
	all_book_info = list(all_book_info)

	cur.close()

	show_list = []

	if page_no == 1:
		for one_to_four in range (0,4):
			try:
				j=all_book_info[k]
				show_list.append(j)
			except IndexError:
				break

	else:
		temp_page = int(page_no) -1
		start_item = temp_page*4

		for k in range(0,4):
			try:
				j=all_book_info[start_item+k]
				show_list.append(j)
			except IndexError:
				break

	if no_of_books > 0:
		header = category[0].upper() + category[1:]
		return render_template('category.html',header=header,category = category,no_of_books=no_of_books,no_of_pages=no_of_pages,all_book_info=all_book_info,page_no=page_no,show_list=show_list)
	else:
		error = 'No '+category+' Found'
		return render_template('home.html', error=error)





# Add to shopping cart
@app.route('/add-order/<string:category>/<string:bookid>/<string:page_no>', methods=['POST'])
@is_logged_in
def add_order(category,bookid,page_no):

	# Create cursor
    cur = mysql.connection.cursor()

    # Retrieve user_id from session 
    userid = session['id']

    # Rejected if out of stock
    cur.execute('SELECT * FROM books WHERE id = %s' %bookid)
    stock = cur.fetchone()
    stock = stock['stock']
    if stock == 0 :
        flash('Currently out of stock', 'danger')

    else:
        # Insert a record to table 'shopping_cart'
        cur.execute("INSERT INTO shopping_cart(bookid,userid) VALUES(%s, %s)", (bookid, userid))

        # Commit to DB
        mysql.connection.commit()

        flash('Added to cart', 'success')
    
    # Pass the variable (category),(page_no) to let user stay at that page avoid losing track
    return redirect(url_for('category',category=category,page_no=page_no))




# Shopping cart
@app.route('/shopping-cart')
@is_logged_in
def shopping_cart():

    # Create cursor
    cur = mysql.connection.cursor()

    # Get user_id with session
    result = cur.execute("SELECT id FROM users WHERE username = %s", [session['username']])


    data = cur.fetchone()
    user_id = data['id']

    # Get the items in shopping cart with that user id
    result = cur.execute("SELECT * FROM shopping_cart WHERE userid = %s", [user_id])

    # Store all items in shopping_cart
    # In a tuple contains dict
    shopping_cart = cur.fetchall()

    # Create a list for showing all the books
    the_book_list=[]

    # Total price
    total = 0

    # Make a list for showing the items in shopping cart
    # Loop through how many items in shopping cart
    for k in range(0,len(shopping_cart)):
        # Extract one single item
        single_order = shopping_cart[k]
        # Extract the column 'bookid'
        book_id = single_order['bookid']
        # Find the information of that book with the bookid
        result = cur.execute("SELECT * FROM books WHERE id = %s", [book_id])
        # Store in book_info
        book_info = cur.fetchone()
        # Add an additional information from another table --> the order id
        book_info.update({'order_id':single_order['id']})
        # Append to a showing list
        the_book_list.append(book_info)
        # Extract the price and add to total
        price = book_info['price']
        total += price


    if the_book_list == []:
        error = 'No items in shopping cart.'
        return render_template('shopping_cart.html', error=error)
    else:
        # A flag to determine to show the pay button and total column
        show = True
        return render_template('shopping_cart.html', the_book_list=the_book_list,total=total,show=show)


# Delete item in shopping cart
@app.route('/delete-order/<string:id>', methods=['POST'])
@is_logged_in
def delete_order(id):
    # Create cursor
    cur = mysql.connection.cursor()

    # Execute
    cur.execute("DELETE FROM shopping_cart WHERE id = %s", [id])

    # Commit to DB
    mysql.connection.commit()

    #Close connection
    cur.close()

    flash('Order deleted', 'success')

    return redirect(url_for('shopping_cart'))






# Confirm and send order from shopping cart
@app.route('/send-order')
@is_logged_in
def send_order():

    # Create cursor
    cur = mysql.connection.cursor()

    # Keep looping until all items in shopping cart are sent to orders
    while True:
        # Get number of items in shopping cart
        no_of_records = cur.execute("SELECT * FROM shopping_cart WHERE userid = %s",[session['id']])
        # If there is no item
        if no_of_records == 0:
            break
        data = cur.fetchone()
        user_id = data['userid']
        book_id = data['bookid']
        # Insert item 'X' to table 'orders' and delete the item 'X' in table shopping cart
        cur.execute("INSERT INTO orders (userid, bookid) VALUES (%s, %s)", [user_id,book_id])
        mysql.connection.commit()
        cur.execute("DELETE FROM shopping_cart WHERE userid = %s AND bookid = %s", [user_id,book_id])
        mysql.connection.commit()

    # Close connection
    cur.close()

    flash('Order sent.', 'success')
    return render_template('shopping_cart.html',data=data,no_of_records=no_of_records,user_id=user_id,book_id=book_id)




 # Order History
@app.route('/order-history')
@is_logged_in
def order_history():

    # Create cursor
    cur = mysql.connection.cursor()

    # Get user id with session
    user_id = session['id']

    # Get all past orders records
    result = cur.execute("SELECT * FROM orders WHERE userid = %s", [user_id])
    all_past_orders = cur.fetchall()

    # New list contains book name, author, price...
    the_book_list=[]

    # Loop through all the past orders
    for k in range(0,len(all_past_orders)):
        single_order = all_past_orders[k]
        # Get the book id
        book_id = single_order['bookid']
        # Using that book id, get the information of that book
        result = cur.execute("SELECT * FROM books WHERE id = %s", [book_id])
        book_info = cur.fetchone()
        # Book_info is in type [{},{},{}...{}]
        # Add information to each single dict
        # Those are order_id, order_date, paid
        book_info.update({'order_id':single_order['id']})
        book_info.update({'order_date':single_order['order_date']})
        book_info.update({'paid':single_order['paid']})
        the_book_list.append(book_info)


    if the_book_list == []:
        error = 'No order history.'
        return render_template('order_history.html', error=error)
    else:
        return render_template('order_history.html', the_book_list=the_book_list,user_id=user_id)




@app.route('/search', methods=['GET', 'POST'])
def search():
	if request.method == 'POST':

        # Get the keyword from the form
		key_word = request.form['search']
		# Create cursor
		cur = mysql.connection.cursor()

		# Get user by username
		statement = 'SELECT * FROM books WHERE name like "%'+key_word+'%"'
		found = cur.execute(statement)
		result = cur.fetchall()

		if found == 0:
			error = 'There is no result.'
			return render_template('new_arrivals.html', error=error)
		else:
			return render_template('search.html', result=result)








if __name__ == '__main__':
    app.secret_key='1111'
    app.run(debug=True)
