/**
 * 
 */
// Retrieve patient vitals data from the backend
// Assume you have an array of vitals data for a patient
const vitalsData = [
    { date: '2023-05-01', bpHigh: 120, bpLow: 80, spO2: 98 },
    { date: '2023-05-02', bpHigh: 130, bpLow: 85, spO2: 95 },
    { date: '2023-05-03', bpHigh: 140, bpLow: 90, spO2: 92 },
    // Additional data points...
];

// Extract dates and vitals values from the data
const dates = vitalsData.map(data => data.date);
const bpHighValues = vitalsData.map(data => data.bpHigh);
const bpLowValues = vitalsData.map(data => data.bpLow);
const spO2Values = vitalsData.map(data => data.spO2);

// Create a line graph using chart.js
const ctx = document.getElementById('vitalsGraph').getContext('2d');
new Chart(ctx, {
    type: 'line',
    data: {
        labels: dates,
        datasets: [
            {
                label: 'BP High',
                data: bpHighValues,
                borderColor: 'red',
                fill: false
            },
            {
                label: 'BP Low',
                data: bpLowValues,
                borderColor: 'blue',
                fill: false
            },
            {
                label: 'SP02',
                data: spO2Values,
                borderColor: 'green',
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
                    text: 'Date'
                }
            },
            y: {
                display: true,
                title: {
                    display: true,
                    text: 'Vital Value'
                }
            }
        }
    }
});
