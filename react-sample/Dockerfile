FROM node:14-buster

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install
RUN npx browserslist@latest --update-db

# add app
COPY . ./

# start app
CMD ["npm", "start"]
EXPOSE 3000
