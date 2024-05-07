[![Workflow](https://github.com/JustineUgo/graphql_simple_blog/actions/workflows/release_workflow.yml/badge.svg)](https://github.com/JustineUgo/graphql_simple_blog/actions/workflows/release_workflow.yml)
<br><br>





# Github Explorer

Github Explorer is a Flutter mobile app designed to provide users with an engaging platform to explore GitHub profiles and repositories, even in environments with limited internet connectivity.

## Overview

Github Explorer utilizes Flutter's capabilities along with various packages and tools to offer a seamless browsing experience for GitHub users. With lightweight MVC architecture, Bloc for state management, auto_route for routing, GetIt & Injectable for dependency injection, and other technologies, Github Explorer ensures efficient performance and smooth navigation.

## Setup

To get started with Github Explorer, follow these steps:

1. Run the following commands:
   ```bash
   $ make setup
    ```
2. Run app:
   ```bash
   $ flutter run
    ```

## Structure

Github Explorer is structured as follows:

- **Dependency Injection**: Utilizes GetIt & Injectable for managing dependencies.
- **Routing**: Implements auto_route for efficient and structured routing.
- **Flutter Version**: v3.19.5

This structured approach ensures clarity, scalability, and maintainability throughout the project.

## CI/CD

The project is equipped with a CI/CD workflow that automates various tasks including dart analysis, build, and release APK generation through GitHub releases.

## Features

Features on the blog app are:

- **Offline Support**: Users can load blog posts even without an internet connection.
- **Search Posts**: Users have the ability to filters blogs by search term.
- **Add, Edit and Delete**: Users can add new posts, edit old posts and delete.
- **Bookmark**: Users have the ability to bookmark their favourite posts.



