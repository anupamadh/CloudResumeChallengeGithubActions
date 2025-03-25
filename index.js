const counter = document.querySelector(".counter-number");
async function updateCounter() {
    let response = await fetch("https://mkdky5gzji.execute-api.ap-southeast-1.amazonaws.com/Prod/DynamoDBManager", {method: 'POST'});
    let data = await response.json();
    counter.innerHTML = `Views: ${data}`;
}

updateCounter();