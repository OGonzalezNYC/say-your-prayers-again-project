// This adapter is what will talk to the backend API. In fact, that's the entire purpose of the adapter. It's the middle man, if you will, the equivalent of a pure Ruby-on-Rails controller.
class PrayersAdapter {
  // An instance of PrayersAdapter will make a fetch request to the backend (api/v1/prayers) and jsonify the response.
  constructor() {
    this.baseUrl = 'http://localhost:3000/api/v1/prayers';
  }

  getPrayers() {
    return fetch(this.baseUrl).then(res => res.json());
  }
}

// Eventually, we'll write:
// let adapter = new PrayersAdapter()
//and
// adapter.getPrayers()
