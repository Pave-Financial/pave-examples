# Pave Sample Admin Dashboard

This is a sample dashboard to show the capabilities of the Financial insights API. 

## Contents

1. [Getting Started](#getting-started)
2. [Setting up](#setting-up)
3. [Development](#development)
4. [Docker](#docker)

## Getting Started
There are two ways to get started with the dashboard. You can either use our [docker image](#docker) for a quick look at the capabilities and the insights provided. You can also set the project up in your [development environment](#setting-up) if you would like to adapt the code to suit any specific needs you might have. 

### Setting up
You need to make sure you have node.js version 14 or greater installed on your development environment. You can find installation instructions on their [official documentation](https://nodejs.org/en/download/). For your convenience, the dashboard's source code is shipped with a `.devcontainer` folder that takes advantage of the VS Code Remote Containers feature. This folder contains a portable development environment that is contains all the pre-requisites for running the development environment. You can find documentation on how to set this up on [VS Code's official documentation](https://code.visualstudio.com/docs/remote/remote-overview).

Once you have node.js set up or once you've spun up the dev container, you need to run `npm install`. This will install the app's dev dependencies. Now you're ready to start modifying the source code.

Additionally, you need to rename the `.env.sample` file to `.env` by running:

```bash
$ cp .env.sample .env
```

Then update the `REACT_APP_API_KEY` variable with one you obtained from us. **Waring: Adding the environment variables in this manner is unsecure and will expose your API Key in the browser.** As a result, this demo is only meant to be used in a development capacity. To learn more about environment variables, click [here](https://create-react-app.dev/docs/adding-custom-environment-variables/).


You can run:

```bash
$ npm run start
```
to start the dev server. This runs the app in the development mode.<br>

Open [http://localhost:3000](http://localhost:3000) to view it in the browser. The page will reload if you make edits. You will also see any lint errors in the console.

Or

```bash
$ npm run build
```

to create an optimized build for production. 

## Development

You'll find the following folder structure in the project.

  ```
  ├── .gitignore
  ├── .dockerignore
  ├── package.json
  ├── package-lock.json
  ├── README.md
  ├── Dockerfile
  ├── docker-compose.yml
  ├── build/
  ├── public/
  │   ├── index.html
  │   └── manifest.json
  └── src/
      ├── assets/
      │   ├── img/
      │   └── scss/
      ├── components/
      ├── data/
      ├── layouts/
      ├── pages/
      ├── redux/
      ├── routes/
      ├── vendor/
      ├── App.js
      └── index.js
  ```

 The main part of the dashboard is located in `src/dashboards/pages/Pave`. This should be your entry point to start changing the dashboard.

### Working with the API

The main code for interacting with the API can be found in `src/redux/actions/apiActions.js`. This is where the API call to the `recurring_expenditures` endpoint is defined.

This app uses `react-redux` to manage the global application state. You can read learn more about it on [their official documentation](https://react-redux.js.org/). The `src/redux` folder contains all the base state management code for the application


## Docker
In order to run the docker version of our sample dashboard, you need to be running on the most recent version of docker. Refer to docker's [official documentation](https://www.docker.com/get-started) for installation instructions.

As a convenience, we've provided a `docker-compose.yml` file to help you get started. 


To start the dashboard, run: 

```bash
$ docker-compose up
```

We will periodically add updated to the docker image as our API matures and gains more capabilities. 
