if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  // Validate form fields
  $errors = [];

  if ($_POST['name'] === '') {
    $errors[] = 'Please enter your name';
  }

  if ($_POST['email'] === '') {
    $errors[] = 'Please enter your email';
  }

  if ($_POST['password'] !== $_POST['confirm-password']) {
    $errors[] = 'Passwords do not match';
  }

  if (count($errors) === 0) {
    // Update user's profile information in the database
    // Redirect to the user's profile page
    header('Location: profile.php');
    exit;
  } else {
    // Display error messages to the user
    echo '<ul>';
    foreach ($errors as $error) {
      echo '<li>' . $error . '</li>';
    }
    echo '</ul>';
  }
}
