import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private isAuthenticated = false;

  signIn(email: string, password: string): boolean {
    // Implement your sign-in logic here (e.g., compare with predefined credentials)
    // Return true if the sign-in is successful, otherwise return false
    if (email === 'lavanya@example.com' && password === 'lavanya') {
      this.isAuthenticated = true;
      return true;
    }
    return false;
  }

  signOut(): void {
    this.isAuthenticated = false;
  }

  isAuthenticatedUser(): boolean {
    return this.isAuthenticated;
  }
}
