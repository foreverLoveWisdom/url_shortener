# A Ruby on Rails backend service for shortening a URL

This README provides information on how to get the project up and running.

## Ruby Version

This project requires Ruby version 3.1.3.

## System Dependencies

This project requires the following system dependencies:

- PostgreSQL RDBMS

## Configuration

The following gems are required for this project:

- rails (~> 7.0.4, >= 7.0.4.2)
- pg (~> 1.4, >= 1.4.5)
- puma (~> 5.0)
- tzinfo-data (platforms: mingw, mswin, x64_mingw, jruby)
- bootsnap (require: false)

The following gems are required for development and testing:

- pry-byebug (~> 3.10, >= 3.10.1)
- awesome_print (~> 1.9, >= 1.9.2)
- pry-rails (~> 0.3.9)
- rspec-rails (~> 6.0, >= 6.0.1)
- faker (~> 3.1, >= 3.1.1)
- database_cleaner (~> 2.0, >= 2.0.1)
- brakeman (~> 5.4)
- bundler-audit (~> 0.9.1)
- overcommit (~> 0.60.0)
- guard (~> 2.18, require: false)
- guard-rspec (~> 4.7, >= 4.7.3, require: false)
- factory_bot_rails('~> 6.2')

The following gems are required for code analysis:

- rubocop-rails (require: false)
- rubocop-rspec (require: false)
- rubocop-performance (require: false)

## Database Creation

To create the database, run:

- rails db:create

## Database Initialization

To initialize the database, run:

- rails db:migrate

## How to Run the Test Suite

To run the test suite, run:

- rspec

## Security

- Possible attack vectors:

  - SQL Injection attacks: The application is protected against SQL Injection attacks by using the ActiveRecord ORM built-in query functions such as find_by
  - Cross-Site Scripting (XSS) attacks: The application is protected against XSS attacks by using the Rails HTML escaping helpers, such as: ActionController::Base.helpers.sanitize
  - DoS attacks: Can be mitigated by using the gem rack-attack or a cloud service such as Cloudflare. The point is we want to rate limiting to limit the number of requests that can be sent to the API endpoints in a given time period

    - rack-attack:

      - Pros:
        - It is a open-source lightweight and easy to use gem
        - It is a Rack middleware, so it can be used with any Rack-based application
        - Free and open source
      - Cons:
        - Requires additional configuration
        - It is not a cloud service, so it requires additional maintenance
        - Limit scaling

    - Cloudflare:

      - Pros:
        - Have free plan
        - It requires no additional maintenance
        - Scale easily up and down depends on the traffic
        - Distributed Denial of Service (DDoS) protection
        - Specialized security features, such as: Web Application Firewall (WAF), Bot Management, etc
      - Cons:
        - Can be expensive if the application is used by a large number of users and needs to be scaled up quickly
        - Vendor lock-in and reduces flexibility

## Scale up approach

- Collision problem: The current approach is fine for the purpose of the demo. If we want to scale up, the following approaches can be considered:

  - Use SecureRandom in Ruby

    - Pros:
      - It is a built-in Ruby library
      - It is a cryptographically secure random number generator
      - Easy to implement
    - Cons:
      - May not be sufficient for high-scale use cases
      - Still possibility of collisions

  - Use base62

    - Pros:
      - Easier to implement versus the Hash function approach
      - Collision is impossible since it depends on a unique ID
    - Cons:
      - The length of the shortened URL is not fixed
      - Can be guessed the next available ID if the ID is sequential such as incremented by 1

  - Use hash function

    - Pros:
      - The length of the shortened URL is fixed
      - Does not need a unique ID
      - Can't be guessed the next available short URL because it does not depend on ID
    - Cons:
      - Collision is possible and must be resolved such as adding a salt value
      - More complex to implement

  - Conclusion:
    - The hash function approach is the best approach for high-scale use cases but we need to handle the possible collision problem
    - The base62 and SecureRandom approach is the best approach for low-scale use cases, but base62 is preferable if our priority is a short and sharable url. If we want a unique and more secured, we should use SecureRandom

- Caching:

  - Implement caching for the most frequently accessed data, such as recently shortened URLs, to reduce the number of database queries.
  - For example, we could use Redis to store the short URL as the key and the long URL as the value, and set an expiration time to ensure the cache is refreshed periodically.
  - Use a distributed caching system like Redis or Memcached, which can be shared across multiple servers and provide high availability.

- Availability:

  - Set up auto-scaling(i.e, Amazon EC2 Autoscaling) to add or remove backend servers automatically based on demand.
  - Use multiple availability zones or data centers(i.e, Amazon Route 53) to ensure that the service is available even if one data center goes down.
  - Can use a tool like AWS Elastic Load Balancer or similar to distribute incoming requests across multiple servers in different availability zones.

- Consistency and Reliability:

  - Use database replication to maintain multiple copies of the database and distribute the read requests across them.
  - Implement database sharding to distribute the write requests across multiple database instances, reducing the load on each individual instance.
  - For example, we can use master-slave replication with PostgreSQL to maintain a master database for write operations and multiple read replicas for read operations.
  - Can use RabbitMQ(or Amazon SQS) as message queue to ensure reliability and consistency, such as if a worker(i.e, shorten url worker) temporarily down, the message will be stored in the queue and will be processed when the worker is back online.

- Analytics:

  - Use a tool like Google Analytics to track the number of clicks on each shortened URL.
  - Or can use New Relic or similar services(i.e, CloudWatch) to measure the performance and health of the application.

- Conclusion:
  - These are the high-level approaches to scale up the application. The actual implementation will depend on the requirements, the current resources as well as unique constraints of each application

## Services

This project uses the following services:

- None

## Deployment Instructions

To deploy this project, follow these steps:

- None

## Contributing

Please follow the community best practices when contributing to this project.

## License

This project is licensed under the [MIT](my_link_to_MIT) license.
