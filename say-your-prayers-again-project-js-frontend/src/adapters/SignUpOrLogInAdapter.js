
class SignUpOrLogInAdapter {

  constructor() {

  }

  submitNewUserInfo(e) {
    e.preventDefault()
    // debugger
    const username = document.querySelector("#new-user-username").value
    const password = document.querySelector("#new-user-password").value
    fetch('http://localhost:3000/api/v1/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json'
      },
      body: JSON.stringify({
        user: {
          username: `${username}`,
          password: `${password}`
        }
      })
    })
    // .then(r => r.json())
    // .then(console.log)
    //
    // .then(new Prayers())






        .then(r => r.json())
        .then(console.log)
        .then(new Prayers())
          .then(response => response.json())
          .then( user => {
            window.userToken = user.jwt;
          })

          .then(new Prayers())
          .then( () => {

            console.log(window.userToken);
            fetch('http://localhost:3000/api/v1/prayers', {
              method: 'POST',
              headers: {
                Authorization: `Bearer ${window.userToken}`,
                'Content-Type': 'application/json',
                Accept: 'application/json'
              },
              body: JSON.stringify({
                prayer: {
                  title: 'title',
                  body: 'body'
                }
              })
            }).then(response => response.json()).then( response => console.log(response)) ;
          });














    // .then(console.log('I need to load the pre-existing prayers.')) //This console.log() works, which means I can chain another function on on to here.
    //"You must enter a unique name and a password. Please try again."
  }

  submitReturningUserInfo(e) {
    e.preventDefault()
    const username = document.querySelector("#login-username").value
    const password = document.querySelector("#login-password").value
    fetch('http://localhost:3000/api/v1/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json'
      },
      body: JSON.stringify({
        user: {
          username: `${username}`,
          password: `${password}`
        }
      })
    })
    .then(r => r.json())
    .then(console.log)

    .then(new Prayers())

    // .then(console.log('I need to load the pre-existing prayers.'))
    //after this adapter function is run by the SignUpOrLogIn instance, that instance should run something like, "document.body.innerHTML = "


    //.then(console.log('I need to load the pre-existing prayers.')) This console.log() works, which means I can chain another function on on to here.
    //"You have entered an invalid username or password. Please try again."
  }

}
