# Albert CRM

![Albert](app/assets/images/albert.png)

Albert CRM is a Rails-based customer relationship management (CRM) tool designed for engaging with clients. Inspired by Albert, the nerdy finance guru, in conjuntion with the case study, this application combines email blast management as well as contact dashboard tools.

## Features

- **Contact Management:** Keep track of contacts, including their financial details, with a user-friendly interface.
- **Email Campaigns:** Send out customized email campaigns using predefined templates and track their success with detailed analytics.
- **Active Admin Integration:** Leverages Active Admin for backend management, providing a powerful and customizable administrative interface.
- **Secure Authentication:** Utilizes Devise for secure login and authentication, ensuring that user data remains protected.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby 3.3.0 (patched)
- Rails 7.1
- PostgreSQL 16

### Installation

1. Clone the repository:

```bash
git clone https://github.com/sideshowbandana/albert_crm.git
cd albert_crm
```

2. Install the required gems:

```bash
bundle install
```

3. Setup the database:

```bash
rails db:create db:migrate db:seed
```

4. Start the Rails server:

```bash
rails server
```

5. Open your browser and navigate to `http://localhost:3000` to view the application.


## Running the App

### Using the Makefile

The project includes a `Makefile` with predefined commands for building, starting, and stopping the application, you can see the available commands by running:
  ```bash
  make help
  ```


### Using docker-compose

- **To build the project:**

  This command builds the Docker images for the application based on the `docker-compose.yml` file.

  ```bash
  docker-compose build
  ```

- **To start the application:**

  Starts up all containers defined in the `docker-compose.yml` file. Add `-d` to run in detached mode.

  ```bash
  docker-compose up
  ```

- **To stop the application:**

  Stops all running containers without removing them. They can be started again with `docker-compose start`.

  ```bash
  docker-compose stop
  ```

- **To remove the containers for a clean restart:**

  ```bash
  docker-compose down
  ```

### Managing and Interacting with Containers

- **To list currently running containers:**

  ```bash
  docker-compose ps
  ```

  Or for a wider system context outside of `docker-compose`:

  ```bash
  docker ps
  ```

- **To tail logs for containers:**

  To follow the logs from all containers started by `docker-compose up`, use:

  ```bash
  docker-compose logs -f
  ```

  If you want to follow logs for a specific service:

  ```bash
  docker-compose logs -f <service_name>
  ```

Replace `<service_name>` with the name of the service as defined in the `docker-compose.yml` file, such as `web` or `worker`.

## Additional Information

For more details on using Docker and Docker Compose for development and deployment, refer to the [Docker documentation](https://docs.docker.com/) and the [Docker Compose documentation](https://docs.docker.com/compose/).

## Customizing

Albert CRM is built to be easily customizable. You can modify the Active Admin interface, add new models, or expand on existing features to fit your needs.

## Contributing

We welcome contributions to Albert CRM! Please read `CONTRIBUTING.md` for details on our code of conduct and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

## Acknowledgments

- Hat tip to all the nerdy finance gurus out there making finance fun and accessible.
- Special thanks to the Rails and Active Admin communities for their invaluable resources.

## Footer

"Powered by caffeine, spreadsheets, and a tiny bit of financial wizardry. - Albert probably"
