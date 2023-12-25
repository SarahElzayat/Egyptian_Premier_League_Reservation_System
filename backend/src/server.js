const { App } = require("./app");

class Server {
  constructor() {
    this.app = new App();
  }
  start() {
    this.app.listen();
  }
}

new Server().start();

let currentDate = new Date(); // current date
console.log(currentDate.toString().split(" ")[4]);
