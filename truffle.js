module.exports = {
  build: {
    "index.html": "index.html",
    "doctor.html": "doctor.html",    
    "app.js": [
      "javascripts/app.js"
    ],
    "doctor.js": [
      "javascripts/doctor.js"
    ],    
    "app.css": [
      "stylesheets/app.css"
    ],
    "images/": "images/"
  },
  rpc: {
    host: "localhost",
    port: 8545
  }
};
