# BOTsy
BOTsy is online store hosting a wide variety of products made by robots. In this app we will focus on reinforcing the major components of rails, model validation, authentication as well as introducing a world in which creative, self-driven, artificially intelligent robots make goods for human consumption.  This is a world without the need for sweatshops and industrial jobs. This is a world where no human is subjugated to the misery of factory work or menial labor. This is a world where robots and human coexist in harmony, bestowing enumerable benefits of convenience and quality of life. This is BOTsy.

#Heroku Site
http://botsy.herokuapp.com/

#Dev Team
- Logan
- Jenna
- Claire


#### General Requirements
- RSpec tests for
  - Controllers
  - Models
  - Routes (optional)
- Test code coverage (using SimpleCov)
  - 90% for all controller and model classes

#### Guest User (Unauthenticated)

As a guest to the website (not signed in) I **can**:

- Browse all products
- Browse products by category
- Browse products by merchant (users)
- View any individual product with additional details
- Leave a review for a product providing:
    - A Text review
    - A rating out of 5
- Add in-stock products to my cart
- Remove products from my cart
- Change the quantity of an existing product in my cart
- Purchase the items in my cart, providing:
    - Email Address
    - Mailing Address
    - Name on credit card
    - Credit card number
    - Credit cart expiration
    - Credit Card CVV (security code)
    - Billing zip code
- Purchasing an order makes the following changes:
    - Reduces the number of inventory for each product
    - Changes the order state from "pending" to "paid"
    - Clears the current cart
- After purchasing an order, I can view a confirmation screen including:
    - Each item in the order with a quantity and line-item subtotal
    - A link to the item description page
    - Order total price
    - DateTime the order was placed
    - The current status of the order
- Sign up to be a merchant, providing:
    - Email Address
    - Username
    - Password (plain text passwords cannot be stored in the database)
    - Password confirmation
- Sign in to my merchant account

As a guest I **cannot**:

- Add products to the cart that are out of stock
- View any link or page to manage any products
- View any of the account pages

#### Authenticated Users

As a signed-in user, I **can**:

- Do everything a guest user can do except for sign up and sign in
- Sign out
- Create new categories (categories are shared between all merchants)
- Create a new product providing:
    - name
    - description
    - price
    - photo URL
    - stock
- Assign my products to any number of categories
- Retire a product from being sold, which hides it from browsing
- View an account page to edit/update my existing products
- View an account page showing my order fulfillment
- On the order fulfillment page:
    - Total Revenue
    - Total Revenue by status
    - Total number of orders by status
    - Filter orders displayed by status
    - Link to each individual order
    - A list of orders including at least one of my products:
        - Each order item sold by me with a quantity and line-item subtotal
        - A link to the item description page
        - DateTime the order was placed
        - Link to transition the order item to marked as shipped
        - The current status of the order ("pending", "paid", "complete", "cancelled")
- View an individual order to see the user's:
    - Name
    - Email address
    - Mailing address
    - Last four digits of their credit card
    - Credit card expiration date

As a signed-in user, I **cannot**:

- Review my own products
- View order items from a shared order that belong to another merchant
- View another users private data (i.e. order fulfillment or product management)

### Model Validations

Many of our models will have attributes that are required for our application to use and display data consistently. Each model will have attributes with requirements for a valid record. The requirements are summarized below:

#### User

- Username must be present
- Username must be unique
- Email Address must be present
- Email Address must be unique
- Password Confirmation must match Password

#### Product

- Name must be present
- Name must be unique
- Price must be present
- Price must be a number
- Price must be greater than 0
- Product must belong to a User

#### Order

- An Order must have one or more Order Items

#### OrderItem

- Must belong to a Product
- Must belong to an Order
- Quantity must be present
- Quantity must be an integer
- Quantity must be greater than 0

#### Review

- Rating must be present
- Rating must be an integer
- Rating must be between 1 and 5

## Submission Guidelines
Your final project must be deployed to [Heroku](http://heroku.com). Your team will open a single pull request for the entire project. Include the link to your Heroku deployment in the PR's description.

Your `README` file on your Github repo should contain a link to your live site.

## Team Leaders
Each team will have team leaders who are responsible for keeping track of each team member's contributions. Rotate leader roles at the beginning of each week; every team member should be in at least one leader role during the project.

- Stand Up Leader
  - Notifies team members about meeting schedule and ensures that everyone is present and ready
  - Takes notes about each person's daily report in Stand Up
  - Keeps the meeting moving
- Task Leader
  - Leads discussion on task assignment
    - Decide if a task should be completed alone or in a pair
    - Assign tasks based on...
      - Individual comfort
      - Desire
      - Ability
  - Ensures the task list stays up to date

## Stand Up Meetings
The Project Manager for your team will determine the timing for all Stand Up meetings. Because PMs are managing multiple projects at once this time will be different for each team, and may change from day to day. The meeting schedule will be communicated to the Stand Up Leader as soon as it is determined.

At the end of each day, your team's assigned Project Manager will review the Trello board for all tasks discussed during that day's Stand Up meeting.

## Weekly Demos
In a real world work environment, a team's success is measured by their product as opposed to each individual's contribution.

Each team will present their progress and respond to questions from their Project Manager each Friday. Every team member will participate in these demos; the PM will ask specific questions regarding 1) the team's progress and plan for completing the project, 2) the technical decisions and implementation, and 3) every team member's understanding of the underlying technical structures.
