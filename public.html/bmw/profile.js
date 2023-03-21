const form = document.querySelector('form');

form.addEventListener('submit', function(e) {
  const nameInput = document.getElementById('name');
  const emailInput = document.getElementById('email');
  const passwordInput = document.getElementById('password');
  const confirmPasswordInput = document.getElementById('confirm-password');

  // Validate form fields
  let errors = [];

  if (nameInput.value.trim() === '') {
    errors.push('Please enter your name');
  }

  if (emailInput.value.trim() === '') {
    errors.push('Please enter your email');
  }

  if (passwordInput.value !== '' && passwordInput.value !== confirmPasswordInput.value) {
    errors.push('Passwords do not match');
  }

  if (errors.length > 0) {
    e.preventDefault();
    alert(errors.join('\n'));
  }
});


const loginForm = document.querySelector('.login-form');
const profileForm = document.querySelector('.profile-form');

// Hide the profile form initially
profileForm.classList.add('hidden');

loginForm.addEventListener('submit', (e) => {
  e.preventDefault();
  // Here you would send a request to the server to authenticate the user
  // If the authentication is successful, show the profile form and hide the login form
  loginForm.classList.add('hidden');
  profileForm.classList.remove('hidden');
});

profileForm.addEventListener('submit', (e) => {
  e.preventDefault();
}
  // Here you would send a request to the server to save
);