import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../services/firebase_course_control.dart';


class AcademicOperation {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getAcYears() async {
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
    List<Map<String, dynamic>> documentIds = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> acY = {
        'documentID': doc.id,
        'currentYear': doc['currentYear'],
      };
      documentIds.add(acY);
    }
    return documentIds;
  }

  Future changeACYear(String currentYear,int year) async {
    return DbCourseMethods().changeAcademicYear(currentYear, year);

  }


  Future<void> addCourseACY(String documentID, String subjectName, String courseCode, String selectedDepartment, String passCode, String semNo) async {
    final localUser = GetStorage();
    final userData = localUser.read('user');

    Map<String, dynamic> courseOriginData = {
      'courseCode':courseCode,
      'subjectName':subjectName,
      'department':selectedDepartment,
      'creator':userData['id'],
      'passCode':passCode,
    };
    DbCourseMethods().createCourse(documentID, courseCode, courseOriginData, semNo);

  }

  Future<List<Map<String, dynamic>>> getMyCourse(acYear, String semNo) async {
    List<Map<String, dynamic>> myCourseList = [];
    List<Map<String, dynamic>> courseList = [];
    courseList = await DbCourseMethods().getCourseInAY(acYear, semNo);
    final localUser = GetStorage();
    final userData = localUser.read('user');
    for (var element in courseList) {
      if (userData['id'] == element['creator']) {
        myCourseList.add(element);
      }
    }
    return myCourseList;
  }

  Future addTopic(acYear, Map<String, dynamic> courseData, Map<String, dynamic> subjectTopic,String semNo) async  {
    await DbCourseMethods().addTopicToCourse(acYear, subjectTopic, semNo, courseData['courseCode']);
  }

  Future<List<Map<String, dynamic>>> getTopics (acYear, semNo, courseCode) async {
    // List<Map<String, dynamic>> topicList = [];
    List<Map<String, dynamic>> receivedList = [];
    receivedList = await DbCourseMethods().getTopicsInSubject(acYear, semNo, courseCode);
    return receivedList;
  }

  Future removeTopic(String acYear, String semNo, String courseCode, String documentId) async {
    DbCourseMethods().removeTopicFromCourse(acYear, semNo, courseCode, documentId);
  }

  Future<String> getYoutubeVideoStreamUrl(String youtubeUrl) async {
    final yt = YoutubeExplode();
    // final video = await yt.videos.get(youtubeUrl);
    // Choose the desired stream based on quality, etc. (see YoutubeExplode documentation)
    final streamManifest = await yt.videos.streamsClient.getManifest(youtubeUrl);
    final videoStreams = streamManifest.muxed;
    final firstVideoStream = videoStreams.withHighestBitrate();
    return firstVideoStream.url.toString();
  }




}
