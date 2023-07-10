import { Component } from '@angular/core';

@Component({
  selector: 'app-contactus',
  templateUrl: './contactus.component.html',
  styleUrls: ['./contactus.component.css']
})
export class ContactusComponent {
  name: string = '';
  email: string = '';
  message: string = '';

  submitForm() {
    // Perform any necessary actions with the form data (e.g., send it to the backend)
    console.log('Form submitted!');
    console.log('Name:', this.name);
    console.log('Email:', this.email);
    console.log('Message:', this.message);

    // Clear the form fields after submission
    this.name = '';
    this.email = '';
    this.message = '';
  }
}
