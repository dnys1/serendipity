import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:serendipity/models/models.dart';

void main() {
  group('JSON parsing', () {
    test('Place.fromJson OK', () {
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
          icon:
              'https://maps.gstatic.com/mapfiles/place_api/icons/museum-71.png',
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

    test('Place.photoReferencesFromJson OK', () {
      String mockJson = '''
{
   "html_attributions" : [],
   "result" : {
      "photos" : [
         {
            "height" : 360,
            "photo_reference" : "CmRaAAAAWONPmhipLKl4SX-kNtwQXw-fKANMOCLzGEqmouv6YPJwi6D--ubVYySPtFMnaXkTdU9nD-4_3N2iyVHr5sX49zhFvXnRo9LZNenqbsqE0BooTxbF12X-Kihc-LquVsMWEhAqMz0xrp-edix05p4fMo4rGhQB0jnhpAMgo78EOgzDVdJoJOLRsQ",
            "width" : 1238
         },
         {
            "height" : 3024,
            "photo_reference" : "CmRaAAAAOi_csMJ81CAqgCNGxsOZASMfBf4GS4Cer33Fw2HXwKblguFHbXlhjS2I90PwHy6L4dPMjlPbJl9XunpWyBrvCCRX1Ymyu0vTTTNJUziBJ4l7wSLpXDLWK0NPbHI0xAM8EhBTqdsqg0tcLZTSNXTwHTbfGhSMcnBb3liAq1qfF-ipcewkargIcg",
            "width" : 4032
         },
         {
            "height" : 540,
            "photo_reference" : "CmRaAAAAXckFB85aF4nhwoDVtcnrCI6VPq8_zSq02Z1ENF1AwW8zrA1vDgRyNrOWR0CCQoeEMV5hi4G2XjZVrrY_R3ZERIFIzDlRPYT3I2s6NXJ-UnmfqYSVyj4lDpQ62DGQOzAXEhBga8uimaNyDv_p7Ib7_Uy8GhQZL570ROeqWoEW_FHquwBZP1f27Q",
            "width" : 960
         },
         {
            "height" : 1512,
            "photo_reference" : "CmRaAAAAMZ62NokPp5KK0PoUX27OP6laCbbO-UyEqFkNb5MTzABBrOnzwAfm_xDPCCAtOTg7KewW0sMbrsZlIThXfU-LwzEEiHQIWXy_oyYDfCAuB91vMbEsCt7vBSgKQX_kT3WjEhAwlCmXG_xQFwws-5fV4gkOGhRRnlWlrkGdBs92Z34VYR3aKeXT2Q",
            "width" : 2016
         },
         {
            "height" : 3024,
            "photo_reference" : "CmRaAAAAeazo3xoapMlDBOFD8V_77wLWfLmqye6ZXT8iJqc9RCuna8fg4KDU6yzX3-NsEKCOUKTtbRnoo5fc1qGmze-VP74M7L_FxHx-2YsGPPxahQLbV4Y8Td9eN3QUtkagbr59EhCjnq-CsQ5z7mqKw9TQ9cYLGhRyfAZ3tbY9WzcUVbXZS28cUe4Ksw",
            "width" : 4032
         },
         {
            "height" : 3024,
            "photo_reference" : "CmRaAAAAg3iUEoGsNnUMWSw1htIcpb9T2FnT_jFY0fmtsrYKaZRZ1_RyS0o4XvO_BEACO1Uc68cI-slBwCXD-t5lA5Xhdxiwc5ib6v_F6UT43r3eA0qBnqn1X119gKpl32JulTOUEhAc5v8hDMnRjNHUH4zZyYeTGhQEhnWmDABBGXvcZRDSfi8NQQtP2Q",
            "width" : 4032
         },
         {
            "height" : 493,
            "photo_reference" : "CmRaAAAA8Q1cSs3JYF3WiafHD1CKdCqp46RPcw3EVzEKT6pKeDG7nPy5Cp3C_8WPh77yrKAQ6cBdc2-mX0ZTHlVpNh-OxobToPAsHbWhiM5FU3-ESSpeusWtpFk78AeQeiol_cbmEhDmDc3VgIu6WSlq-CtPRboWGhTsHphWNcoxPprRLR4n-HnqYTmkkw",
            "width" : 443
         },
         {
            "height" : 478,
            "photo_reference" : "CmRaAAAACSfeLAehr1eG-TlCDwudlydIhLVjR4jeEBgE2ceBr0fM1xXj4t-NEVr7-Has1LQB6c1KN777GWI_ofSFxOZCimFULpQtT_5RP3vtVjroVfk6UeLy8IwiAOIqIMrPp9mKEhDmdeJ3urBWd6fpSGUU1wipGhTh9fG66c__x-K-VMCwAX43JbzShw",
            "width" : 433
         },
         {
            "height" : 473,
            "photo_reference" : "CmRaAAAALnzir__fB6Fw_44VAtzLjlQOzAfzmtzq8yumEj0sBjTZWCaZNOCcRo_dbTRQN9TOh3WQMqIb47fM2BsaLq48IkCCu7L0QGPeL9Dv2iBD1R484ZUY0ZW-cMEgVDr18f21EhBXxEAN4DyiZIX05SqB5sE4GhRa3fwJd0o0KtRSocf3oa5MbGLu3Q",
            "width" : 418
         },
         {
            "height" : 4032,
            "photo_reference" : "CmRaAAAA8NL7O_wvF1tTX7fn9RVIzWi6IzLuWcBJ2Bk52GnWFiNUiLPDY93DO8cYSmMZW4DcYoXczDj6Y49PvCGG6ySDQDjxcQzbBHDIms0j7aXC4uecbvdbQWKoqX75hOWlEzbDEhAHtETIa4GhID2b0pTQAPw1GhTCOjrrVVG6NfSIeKt1qtcS_9SGiQ",
            "width" : 2268
         }
      ]
   },
   "status" : "OK"
}
      ''';

      PlacesDetailResponse response =
          PlacesDetailResponse.fromJson(json.decode(mockJson));

      expect(response.status, PlacesResponseStatus.OK);

      expect(Place.photoReferencesFromJson(response.result['photos']), [
        PlacesPhoto(
          id: 'CmRaAAAAWONPmhipLKl4SX-kNtwQXw-fKANMOCLzGEqmouv6YPJwi6D--ubVYySPtFMnaXkTdU9nD-4_3N2iyVHr5sX49zhFvXnRo9LZNenqbsqE0BooTxbF12X-Kihc-LquVsMWEhAqMz0xrp-edix05p4fMo4rGhQB0jnhpAMgo78EOgzDVdJoJOLRsQ',
          maxHeight: 360,
          maxWidth: 1238,
        ),
        PlacesPhoto(
          id: 'CmRaAAAAOi_csMJ81CAqgCNGxsOZASMfBf4GS4Cer33Fw2HXwKblguFHbXlhjS2I90PwHy6L4dPMjlPbJl9XunpWyBrvCCRX1Ymyu0vTTTNJUziBJ4l7wSLpXDLWK0NPbHI0xAM8EhBTqdsqg0tcLZTSNXTwHTbfGhSMcnBb3liAq1qfF-ipcewkargIcg',
          maxHeight: 3024,
          maxWidth: 4032,
        ),
        PlacesPhoto(
          id: 'CmRaAAAAXckFB85aF4nhwoDVtcnrCI6VPq8_zSq02Z1ENF1AwW8zrA1vDgRyNrOWR0CCQoeEMV5hi4G2XjZVrrY_R3ZERIFIzDlRPYT3I2s6NXJ-UnmfqYSVyj4lDpQ62DGQOzAXEhBga8uimaNyDv_p7Ib7_Uy8GhQZL570ROeqWoEW_FHquwBZP1f27Q',
          maxHeight: 540,
          maxWidth: 960,
        ),
        PlacesPhoto(
          id: 'CmRaAAAAMZ62NokPp5KK0PoUX27OP6laCbbO-UyEqFkNb5MTzABBrOnzwAfm_xDPCCAtOTg7KewW0sMbrsZlIThXfU-LwzEEiHQIWXy_oyYDfCAuB91vMbEsCt7vBSgKQX_kT3WjEhAwlCmXG_xQFwws-5fV4gkOGhRRnlWlrkGdBs92Z34VYR3aKeXT2Q',
          maxHeight: 1512,
          maxWidth: 2016,
        ),
        PlacesPhoto(
          id: 'CmRaAAAAeazo3xoapMlDBOFD8V_77wLWfLmqye6ZXT8iJqc9RCuna8fg4KDU6yzX3-NsEKCOUKTtbRnoo5fc1qGmze-VP74M7L_FxHx-2YsGPPxahQLbV4Y8Td9eN3QUtkagbr59EhCjnq-CsQ5z7mqKw9TQ9cYLGhRyfAZ3tbY9WzcUVbXZS28cUe4Ksw',
          maxHeight: 3024,
          maxWidth: 4032,
        ),
        PlacesPhoto(
          id: 'CmRaAAAAg3iUEoGsNnUMWSw1htIcpb9T2FnT_jFY0fmtsrYKaZRZ1_RyS0o4XvO_BEACO1Uc68cI-slBwCXD-t5lA5Xhdxiwc5ib6v_F6UT43r3eA0qBnqn1X119gKpl32JulTOUEhAc5v8hDMnRjNHUH4zZyYeTGhQEhnWmDABBGXvcZRDSfi8NQQtP2Q',
          maxHeight: 3024,
          maxWidth: 4032,
        ),
        PlacesPhoto(
          id: 'CmRaAAAA8Q1cSs3JYF3WiafHD1CKdCqp46RPcw3EVzEKT6pKeDG7nPy5Cp3C_8WPh77yrKAQ6cBdc2-mX0ZTHlVpNh-OxobToPAsHbWhiM5FU3-ESSpeusWtpFk78AeQeiol_cbmEhDmDc3VgIu6WSlq-CtPRboWGhTsHphWNcoxPprRLR4n-HnqYTmkkw',
          maxHeight: 493,
          maxWidth: 443,
        ),
        PlacesPhoto(
          id: 'CmRaAAAACSfeLAehr1eG-TlCDwudlydIhLVjR4jeEBgE2ceBr0fM1xXj4t-NEVr7-Has1LQB6c1KN777GWI_ofSFxOZCimFULpQtT_5RP3vtVjroVfk6UeLy8IwiAOIqIMrPp9mKEhDmdeJ3urBWd6fpSGUU1wipGhTh9fG66c__x-K-VMCwAX43JbzShw',
          maxHeight: 478,
          maxWidth: 433,
        ),
        PlacesPhoto(
          id: 'CmRaAAAALnzir__fB6Fw_44VAtzLjlQOzAfzmtzq8yumEj0sBjTZWCaZNOCcRo_dbTRQN9TOh3WQMqIb47fM2BsaLq48IkCCu7L0QGPeL9Dv2iBD1R484ZUY0ZW-cMEgVDr18f21EhBXxEAN4DyiZIX05SqB5sE4GhRa3fwJd0o0KtRSocf3oa5MbGLu3Q',
          maxHeight: 473,
          maxWidth: 418,
        ),
        PlacesPhoto(
          id: 'CmRaAAAA8NL7O_wvF1tTX7fn9RVIzWi6IzLuWcBJ2Bk52GnWFiNUiLPDY93DO8cYSmMZW4DcYoXczDj6Y49PvCGG6ySDQDjxcQzbBHDIms0j7aXC4uecbvdbQWKoqX75hOWlEzbDEhAHtETIa4GhID2b0pTQAPw1GhTCOjrrVVG6NfSIeKt1qtcS_9SGiQ',
          maxHeight: 4032,
          maxWidth: 2268,
        ),
      ]);
    });

    test('Place.photoReferencesFromJson Zero Results', () {
      String mockJson = '''
      {
        "html_attributions": [],
        "result": {
            "photos": []
        },
        "status": "ZERO_RESULTS"
      }
      ''';

      PlacesDetailResponse response = PlacesDetailResponse.fromJson(json.decode(mockJson));

      expect(response.status, PlacesResponseStatus.ZERO_RESULTS);

      expect(Place.photoReferencesFromJson(response.result['photos']), []);
    });
  });
}
