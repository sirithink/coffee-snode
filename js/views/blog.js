window.BlogItemView = Backbone.View.extend({
    render: function () {
        console.log(this);
        $(this.el).html(this.template({blog: this.model}));
        return this;
    }
});