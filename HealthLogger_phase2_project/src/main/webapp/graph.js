fetch('/getVitalData?patientid=1')
    .then(response => response.json())
    .then(data => {
        const dates = data.map(vital => vital.recordedtime);
        const bplowValues = data.map(vital => vital.bplow);
        
        // Create the chart using Chart.js
        const ctx = document.getElementById('VitalsChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [
                    {
                        label: 'BP Low',
                        data: bplowValues,
                        borderColor: 'red',
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Time'
                        }
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: 'BP Low'
                        }
                    }
                }
            }
        });
    })
    .catch(error => {
        console.error('Error:', error);
    });
