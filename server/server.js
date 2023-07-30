const express = require('express');
const app = express();
const path = require('path');

// Указываем путь к вашему Flutter веб-проекту
const flutterWebProjectPath = path.join(__dirname, 'public');

// Указываем, что папка с вашим проектом должна быть статической
app.use(express.static(flutterWebProjectPath));


app.get('/', (req, res) => {
    res.sendFile(path.join(flutterWebProjectPath, 'index.html'));
});


const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
