# Little Esty Shop


## Getting Started

1. In your terminal, navigate to the directory you would like to host the repository in.
2. Clone the project repository and navigate to the main project directory:

```
git clone git@github.com:The-J-MAK-5/little-shop-7.git
```

3. Run `bundle install` in your terminal to install project gems.

4. Ensure that Postgres is running, and run these commands to initialize the databases and set up database structure:

```
rails db:drop
rails db:create
rails db:migrate
```

5. Run `rake csv_load:all` in your terminal to load in data from the six CSVs stored locally in the application.

6. Run the `bundle exec rspec` command to see all of the Rspec tests run and ensure the program is running properly.

## Testing

- To run model tests for this app, type the following command in your terminal:

```
bundle exec rspec spec/models
```

- To run model tests for this app, type the following command in your terminal:

```
bundle exec rspec spec/features
```

This application uses the `Simplecov` gem to monitor test coverage.

## Deployment

This application is deployed with Render [here](https://little-shop-7.onrender.com)

## Project Status and Potential Next Steps

View the project management tracker and any open issues by clicking [here](https://github.com/orgs/The-J-MAK-5/projects/1).

### Description Of The Project

![image](https://github.com/The-J-MAK-5/little-shop-7/assets/124642113/b604734c-a2ba-432d-8920-e1da15737e12)

This is a fictitious e-commerce platform that allows Merchants and Admins to view and manage their inventory and fulfill customer invoices.

Through this project, our team tried to accomplished the following learning goals:

- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together
- Utilize advanced active record techniques to perform complex database queries

### Looking Ahead

- Styling to implement a more consistent look and feel throughout the application
- Finishing All User Stories
- Authentication and authorization, for either or both of the Merchant and Administrator user types.

## Contributors

Ashley Plasket
[GitHub](https://github.com/aplasket)
[LinkedIn](https://www.linkedin.com/in/ashley-plasket/)

Myles Nottingham
[GitHub](https://github.com/MylesNottingham)
[LinkedIn](https://www.linkedin.com/in/mylesnottingham/)

Kim Bergstorm
[GitHub](https://github.com/kbergstrom78)
[LinkedIn](https://www.linkedin.com/in/kimberley-bergstrom/)

Jeff Nelson
[GitHub](https://github.com/jpnelson85)
[LinkedIn](www.linkedin.com/in/jeff-nelson-307ab)

Alex Kiselich
[GitHub](https://github.com/AlexKiselich)
[LinkedIn](linkedin.com/in/alexanderkiselich)
