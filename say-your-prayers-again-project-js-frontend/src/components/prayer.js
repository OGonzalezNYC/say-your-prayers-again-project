class Prayer {
  constructor(prayerJSON) {
    this.id = prayerJSON.id;
    this.title = prayerJSON.title;
    this.body = prayerJSON.body;
    this.outcome = prayerJSON.outcome;
    this.amens = prayerJSON.amens;
    this.user_id = prayerJSON.user_id;
  }

  renderLi() {
    return `<li><div>Title: ${this.title}</div><div>Prayer: ${this.body}</div><div><input type="submit" value="Amen" class="add-amen-button"/> ${this.amens}</div><div>Outcome: ${this.outcome}</div><input type="submit" value="Add Outcome" class="add-outcome-button"/></li><br>`
  }
}
