function RequestedItemsList(items) {
  this.requests = [];
  this.items = items;
  this.populate();
  this.total = 0;
  this.updateTotal();
}

RequestedItemsList.prototype = {
  populate: function() {
    for(var i = 0; i < this.items.length; i++) {
      this.requests.push(this.items[i]);
    }
    this.updateTotal();
  },

  reduceQuantity: function(request) {
    for(var i=0; i<this.requests.length; i++) {
      if (request === this.requests[i]) {
        this.requests[i].quantity--;
      }
    }
    this.updateTotal();
  },

  increaseQuantity: function(request) {
    for(var i=0; i<this.requests.length; i++) {
      if (request === this.requests[i]) {
        this.requests[i].quantity++;
      }
    }
    this.updateTotal();
  },

  updateTotal: function() {
    this.total = 0;
    for(var i=0; i<this.requests.length; i++) {
      this.total += this.requests[i].price * this.requests[i].quantity;
    }
  }
};
