import 'package:hive/hive.dart';
part 'profilehiveclass.g.dart';


@HiveType(typeId: 0)
class ProfileDetails extends HiveObject {
  @HiveField(0)
  final String nameofUser;

  @HiveField(1)
  final String initialWalletBalance;

  @HiveField(2)
  final String? imageUrl;

  ProfileDetails({
    required this.nameofUser,
    required this.initialWalletBalance,
    this.imageUrl,
  });
}
