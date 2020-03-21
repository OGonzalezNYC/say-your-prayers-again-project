//This Prayers class is where the meat of the program will reside.
class Prayers {
  constructor() {
    this.prayers = [];
    this.adapter = new PrayersAdapter();

    //this.initBindingsAndEventListeners();

    this.fetchAndLoadPrayers(); //with this "()", the instantiation of a new instance of the Prayers class doesn't merely ENDOW the instance with this function; it actually CALLS the function, fetchAndLoadPrayers, which is defined below.
  }

  // initBindingsAndEventListeners() {
  //   this.prayersContainer = document.getElementById("prayers-container");
  // }

  fetchAndLoadPrayers() {
    this.adapter
      .getPrayers()
      .then(prayers => { // the calling of this fetchAndLoadPrayers function, which is triggered by the instantiation of an instance of the Prayers class, as described above, automatically calls the getPrayers function, as defined in the PrayersAdapter class, an instance of which is instantiated as an attribute of the Prayers instance that has been instantiated by the instantiation of an App instance, which was instantiated in index.js.
    //console.log(prayers); // The fact that this 1st console.log() works, means that that we're successfully getting the data from the API. Now we need to append that data to the DOM, for which we will define and call a "render" method, as defined below.

        //return console.log(prayers) // The fact that this 2nd console.log() works (after having replaced the 1st), again, means that that we're successfully getting the data from the API. (I think that the use of "return" somehow enables "prayers" to get passed along to the next ".then").
        
        prayers.forEach(prayer => this.prayers.push(new Prayer(prayer))) //"this.prayers" is the array of all prayers, as defined above. Given that we are successfully requesting and receiving a JSONized array of all prayers, we need to iterate through that array in order to render each prayer as an individual prayer. So, rather than simply pushing "prayer" into this.prayers, which starts off empty, we push it in AS A NEW INSTANCE of Prayer, defined in prayer.js.
    })
    .then(() => {
      this.render()
    })
  }

  render() {// We want to call this method after we get all the prayers.
    //const prayersString = this.prayers.map(prayer => `<li>${prayer.title}</li>`).join('')
    //console.log('rendering...')// The fact that this console.log() works, means
    //console.log(prayersString)// The fact that this console.log() is working means that the array of all prayers is reaching this far.
    //console.log(this.prayers[0])
    const prayersContainer = document.getElementById("prayers-container");
    //prayersContainer.innerHTML = 'my prayers here' // The fact that 'my prayers here' successfully
    //populates the "prayers-container" div, means it's all working so far.

    // make the new-user-registration form and the log-in-form vanish.


    prayersContainer.innerHTML = //this.prayers.map(prayer => `<li>${prayer.title}</li>`).join('')

    this.prayers.map(prayer => prayer.renderLi()).join('')
    //Now I'll want to document.getElementsByClassName("add-amen-button") and document.getElementsByClassName("add-outcome-button"), and add an eventListener to each one.

    //Datasets are for adding id's dynamically.
    //data-id = prayer.id

  }
}
