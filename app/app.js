const jsonServer = require('json-server')
const ip = require('ip');
const os = require("os");
const fs = require('fs');
const fileUpload = require('express-fileupload');
var sanitize = require("sanitize-filename");

const ipAddress = ip.address();
const server = jsonServer.create()
const router = jsonServer.router('/db.json')
const dbjson = require('../db.json')
const middlewares = jsonServer.defaults()
const hostname = os.hostname();


server.use(fileUpload());

server.post('/upload', function(req, res) {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('No files were uploaded.');
  }

  // The name of the input field (i.e. "sampleFile") is used to retrieve the uploaded file
  let myFile = req.files.myFile;

  // Use the mv() method to place the file somewhere on your server
  myFile.mv(`/app/upload/${myFile.name}`, function(err) {
    if (err)
      return res.status(500).send(err);

    res.json({"uploaded": myFile.name});
  });
});

server.use('/ping',(req,res,next) => {
  let r = `Hostname: ${hostname} IP: ${ipAddress}`;
  console.log(`Got ping, responding with: ${r}`);
  res.send(r);
})

server.get('/upload',(req,res,next) => {
  console.log("Listing upload dir");

  let filenames = fs.readdirSync('/app/upload');
/*
  let o = "";
  filenames.forEach(file => {
    console.log(file)
    o+= file+"<br>\n";
  });
  res.send(o);
*/
  let o = [];
  filenames.forEach(file => {
    console.log(file)
    o.push(file);
  });
  res.json(o);
})

server.delete('/upload',(req,res,next) => {
  let filename=sanitize(req.query.filename);
  let filepath=`/app/upload/${filename}`;
  console.log(`Will delete ${filepath}`);
  try{
    fs.unlinkSync(filepath);
     res.send("ok");
  } catch (err) {
    res.send("error");
  }
})

server.use(middlewares)
server.use(router)

server.listen(3000, () => {
  console.log('JSON Server is running on port 3000');
  console.log(JSON.stringify(dbjson,null,' '));
})
