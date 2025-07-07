
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const ejs = require('ejs') 
const path = require('path');
const port = 3000
const app = express();
app.use(express.static('./public'));
app.use(express.urlencoded({ extended: false }))



mongoose.connect('mongodb+srv://dhruv:test12345@test.grsdcvo.mongodb.net/?retryWrites=true&w=majority&appName=test', {
//   useNewUrlParser: true,
//   useUnifiedTopology: true
}).then(() => {
  console.log('Connected to MongoDB Atlas');
}).catch((err) => {
  console.error('Error connecting to MongoDB Atlas:', err.message);
});

// Define Mongoose schema and model
const userSchema = new mongoose.Schema({
  name: String,
  email: String,
  password: String
});

const user = mongoose.model('User', userSchema);




app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.get('/', (req,res)=>{
    res.render('index')
})

app.get('/contact-us', (req,res)=>{
    res.render('contact-us')
})

app.get('/index', (req,res)=>{
    res.render('index')
})

app.get('/about', (req,res)=>{
    res.render('about')
})

app.get('/login', (req,res)=>{
    res.render('login')
})

app.get('/signup', (req,res)=>{
    res.render('signup')
})

app.get('/services', (req,res)=>{
    res.render('services')
})


app.listen(port, ()=>{
    console.log('Server at 3000')
})


app.post("/signup", async (req, res) => {

    try{
    
    const data = new user({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
    })
    await user.insertMany([data])
    res.render("index")

    }catch(e){
        console.log(e.message)
    }
    
   

})
app.post("/login", async (req, res) => {
    try {
        const checking = await user.findOne({ name: req.body.name })
        if (checking.password === req.body.password) {
            res.render("index")
        }
        else {
            res.send("Wrong Password")
        }

    }
    catch(e) {
        console.log(e.message)
    }



})
