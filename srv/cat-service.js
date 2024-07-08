const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { Products, ETS_MY_QUOTES } = this.entities;

  const service = await cds.connect.to("Northwind");
  this.on("READ", "Products", async (req) => {
    const qry = await service.run(req.query);
    return qry;
  });

  this.on("submitUser", async (reqData) => {
    // const val = await service.send(
    //   "GET",
    //   "/Products?$filter=ProductID eq " + reqData.data.prodID
    // );
    await this.emit ('addUser', { uid: 3, fname:'Test User', gender: 'Male', prodID: 3 });
    return "Success";
  });

  const srv = await cds.connect.to("zmy_quotes");
  this.on("READ", ETS_MY_QUOTES, async (request) => {
    const qry = await srv.run(request.query);
    return qry;
  });

  this.after("READ", ETS_MY_QUOTES, (reqData) => {
    for (var i = 0; i < reqData.length; i++) {
      if (reqData[i].DealType == "Lease") {
        reqData[i].DealType = "L";
      } else {
        reqData[i].DealType = "P";
      }
    }
  });

});