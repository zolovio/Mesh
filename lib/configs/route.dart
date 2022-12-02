import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/home_screen.dart';
import 'package:mesh/screens/apply_details_screen.dart';
import 'package:mesh/screens/bank_details_screen.dart';
import 'package:mesh/screens/chat_screen.dart';
import 'package:mesh/screens/comment_screen.dart';
import 'package:mesh/screens/error_screen.dart';
import 'package:mesh/screens/login_screen.dart';
import 'package:mesh/screens/message_screen.dart';
import 'package:mesh/screens/more_apply_details_screen.dart';
import 'package:mesh/screens/prepare_screen.dart';
import 'package:mesh/screens/select_skill_screen.dart';
import 'package:mesh/screens/splash_screen.dart';
import 'package:mesh/screens/upload_screen.dart';
import 'package:mesh/screens/verify_screen.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: "/select", page: () => const SelectSkillScreen()),
  GetPage(name: "/home", page: () => const HomeScreen()),
  GetPage(name: "/comment", page: () => CommentScreen()),
  GetPage(name: "/messages", page: () => const MessageScreen()),
  GetPage(name: "/chat", page: () => const ChatScreen()),
  GetPage(name: "/upload", page: () => const UploadScreen()),
  GetPage(name: "/apply-details", page: () => ApplyDetailsScreen()),
  GetPage(
      name: "/more-apply-details", page: () => const MoreApplyDetailsScreen()),
  GetPage(name: "/error", page: () => const ErrorScreen()),
  GetPage(name: "/login", page: () => const LoginScreen()),
  GetPage(name: "/verify", page: () => const VerifyScreen()),
  GetPage(name: "/", page: () => const SplashScreen()),
  GetPage(name: "/prepare", page: () => const PrepareScreen()),
  GetPage(name: "/bank-details", page: () => const BankDetailsScreen()),
  // GetPage(name: "/payment", page: () => PaymentScreen()),
  // GetPage(
  //     name: "/payment-confirmation",
  //     page: () => const PaymentConfirmationScreen()),
  // GetPage(name: "/create-post", page: () => const CreatePostScreen()),
  // GetPage(name: "/chat", page: () => const ChatScreen()),
  // GetPage(name: "/group-details", page: () => const GroupDetailsScreen()),
  // GetPage(name: "/create-group", page: () => const CreateGroupScreen()),
  // GetPage(name: "/add-group", page: () => const AddGroupNameScreen()),
];
