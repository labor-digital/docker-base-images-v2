# LABOR.digital - Docker Base Images

This is a mono-repository for all our docker base images we use in our projects. Currently, we have multiple tech-stacks for NODE.js and PHP.
We have a unique tag for each minor release of those stacks. The base images come with a bunch of extensions already preconfigured.

Note: As we are a company based in Germany, the locale and timezone are already preconfigured for Germany!

## Image Variants
We have multiple variants for each tech stack. By default, each stack has a base variant and
a dev variant. The "-dev" variant is used for local development and for installing / building dependencies (composer/npm) in the CI pipeline.
The production image, on the other hand, only inherits from the base image, so only the required code ends up in your prod environment.

- stackxx: ```labordigital/docker-base-images-v2:phpxx``` 
    The root image the other variants inherit from
- stackxx-dev: ```labordigital/docker-base-images-v2:phpxx-dev```
    The base image with additional helpers for the development environment like composer already installed.

## Environment Variables
All environment variables that are inherited from the base image ([PHP](https://hub.docker.com/_/php) | [NODE](https://hub.docker.com/_/node))

In addition we have those two environment variables for the packages
- PROJECT_ENV ("prod") Helper to define the environment for your application. SHOULD BE "dev", "staging" or "prod";
- APACHE_WEBROOT ("/var/www/html") Defines the apache webroot directory

## Doppler
All our dev and prod stack heavily relies on Doppler as secret store.
So all our images use ```doppler run``` as CMD.

But you can easily overwrite that by using your own CMD in your DOCKERFILE or in ```docker run```.

## Boilerplate
In some stack directories, you will find a "boilerplate" folder, containing a basic project implementation using the images.
To use them, clone them to your device, search and replace "§PROJECT_NAME§" in the sources, with a name of your liking and start the development environment using docker-compose up.

If you want more convenience, you can use our [CLI tool](https://github.com/labor-digital/lab-cli).


## Postcardware
You're free to use these images, but if it makes it to your production environment, we highly appreciate you sending us a postcard from your hometown, mentioning which of our package(s) you are using.

Our address is: LABOR.digital - Fischtorplatz 21 - 55116 Mainz, Germany.

We publish all received postcards on our [company website](https://labor.digital).
