
// const { MongoClient, ServerApiVersion } = require('mongodb');
// const uri = "mongodb+srv://dhruvjoshi1069:cM3TfAyrQ4uzizCq@test.grsdcvo.mongodb.net/?retryWrites=true&w=majority&appName=test";

const { MongoClient } = require('mongodb'); 
 
// Connection URI 
const uri = "mongodb+srv://dhruvjoshi1069:cM3TfAyrQ4uzizCq@test.grsdcvo.mongodb.net/?retryWrites=true&w=majority&appName=test"; 
 
// Database Name
const dbName = 'my_database'; 

// Create a new MongoClient
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

async function main() {
    try {
        // Connect the client to the server
        await client.connect();
        console.log('Connected to MongoDB server');

        // Select the database
        const db = client.db(dbName);

        // Example: Insert document into a collection
        const collection = db.collection('documents');
        await collection.insertOne({ name: 'John', email: "dhruvjoshi123@gmail.com", password: "123456" });

        // Example: Find documents in a collection
        // const result = await collection.find({}).toArray();
        // console.log('Documents found:', result);

    } finally {
        // Close the client
        await client.close();
        console.log('Connection to MongoDB closed');
    }
}

main().catch(console.error);
