import 'package:logger/logger.dart';

class FeatureHelper {
  FeatureHelper._();
  static final FeatureHelper getInstance = FeatureHelper._();
  var log = Logger();

  //todo get Feature From Api 
    // Future<List<Feature>> getFeatureApi() async{
    //   try {
    //   var response = await FeatureApi.getInstance.getAppFeature(url: "${ConstanceNetwork.featureEndPoint}", header: ConstanceNetwork.header(0));
    //   if (response.status?.success == true) {
    //     List data = response.data;
    //     return data.map((e) => Feature.fromJson(e)).toList();
    //   } else {
    //     return [];
    //   }
    // } catch (e) {
    //   log.d(e.toString());
    //   return [];
    // }
    // }
}