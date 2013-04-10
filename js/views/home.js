window.HomeView = Backbone.View.extend({
    render:function () {
        // console.log( this.model );
        $(this.el).html(this.template({blogs: this.model}));
        return this;
    }
});
