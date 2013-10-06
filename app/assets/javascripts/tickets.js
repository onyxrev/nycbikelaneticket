(function(){
    window.NYC = window.NYC || {};
    NYC.Geocoder = function(element, address){
        var self = this;

        this.address  = address;
        this.geocoder = new google.maps.Geocoder();

        this.element  = $(element).fadeIn();
        this.element.data("geocoder", this);

        this.$map     = this.element.find(".map");
        this.$message = this.element.find(".message");

        this.map = new google.maps.Map(this.$map[0], {
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        this.$message.hide().removeClass("alert-success alert-danger");

        this.geocoder.geocode( { 'address': this.address }, function(results, status) {
            self.$message.show();

            if (status == google.maps.GeocoderStatus.OK) {
                self.map.setCenter(results[0].geometry.location);

                var marker = new google.maps.Marker({
                    map: self.map,
                    position: results[0].geometry.location
                });

                self.$message.addClass("alert-success").text("Looks like we may have found your ticket location. Does this look right?");
            }
            else{
                self.$message.addClass("alert-danger").text("We weren't able to find that ticket location. Try something more specific.");
            }
        });
    };

    NYC.Geocoder.prototype = {
        destroy: function(){
            this.$map.empty();
            this.element.fadeOut(0);
        }
    }

    $(document).bind("ready page:load", function(){
        var $map = $("#location_map");

        $("#ticket_location").blur(function(){
            var oldGeocoder = $map.data("geocoder");
            if (oldGeocoder) oldGeocoder.destroy();

            var address  = $(this).val();
            var geocoder = new NYC.Geocoder($map, address);
        });

        $map.hide(0);
    });
})();
