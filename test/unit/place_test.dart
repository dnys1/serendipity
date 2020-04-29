import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:serendipity/models/models.dart';

void main() {
  test('Place.fromJson', () {
    String mockJson = """
    {
         "business_status" : "CLOSED_TEMPORARILY",
         "geometry" : {
            "location" : {
               "lat" : 37.7882406,
               "lng" : -122.4052008
            },
            "viewport" : {
               "northeast" : {
                  "lat" : 37.78955517989272,
                  "lng" : -122.4038439201072
               },
               "southwest" : {
                  "lat" : 37.78685552010728,
                  "lng" : -122.4065435798927
               }
            }
         },
         "icon" : "https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png",
         "id" : "42ed81161c8d9f43472cdd012743668faf6d6cc1",
         "name" : "Kiosk museums",
         "permanently_closed" : true,
         "photos" : [
            {
               "height" : 4032,
               "photo_reference" : "CmRaAAAARRahGcUUvO2AIwzJntwdlb_Xh1LcRmBTikZBfPh9KknQpMgS6K3Aeg88u1FUzRb31aIScjcRDhD4iOxnjsEYTT-l3yWATi18KUJjQZEH3YDik0D1csrGFkgHKB0h9gJ-EhBfwRmvRUtzjVzQFBf7bRLJGhTKhKbwF84nhZqQFNmyfqoGycbCpQ",
               "width" : 3024
            }
         ],
         "place_id" : "ChIJz5tM4oiAhYARMkZNXaR-f9E",
         "plus_code" : {
            "compound_code" : "QHQV+7W Financial District, San Francisco, CA",
            "global_code" : "849VQHQV+7W"
         },
         "rating" : 5,
         "reference" : "ChIJz5tM4oiAhYARMkZNXaR-f9E",
         "scope" : "GOOGLE",
         "types" : [ "museum", "tourist_attraction", "point_of_interest", "establishment" ],
         "user_ratings_total" : 2,
         "vicinity" : "Grant Ave & Maiden Ln, San Francisco"
      }
    """;

    expect(
      Place.fromJson(json.decode(mockJson)),
      Place(
        id: 'ChIJz5tM4oiAhYARMkZNXaR-f9E',
        name: 'Kiosk museums',
        icon: 'https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png',
        rating: 5,
        photoReferences: [
          PlacesPhoto(
            id: 'CmRaAAAARRahGcUUvO2AIwzJntwdlb_Xh1LcRmBTikZBfPh9KknQpMgS6K3Aeg88u1FUzRb31aIScjcRDhD4iOxnjsEYTT-l3yWATi18KUJjQZEH3YDik0D1csrGFkgHKB0h9gJ-EhBfwRmvRUtzjVzQFBf7bRLJGhTKhKbwF84nhZqQFNmyfqoGycbCpQ',
            maxHeight: 4032,
            maxWidth: 3024,
          ),
        ],
      ),
    );
  });
}
