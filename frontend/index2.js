document.addEventListener('DOMContentLoaded', function(){
    fetch('https://g3b9wppyz7.execute-api.ap-southeast-1.amazonaws.com/prod/visitor_count')
    .then(response => response.json())
    .then(data => {
        let visitor_count = data.Views;
        console.log(visitor_count);
        document.querySelector('.counter-number').innerHTML = `Views: ${visitor_count}`;
    })
    .catch(error => {
        console.log('Error:', error);
    });
});
