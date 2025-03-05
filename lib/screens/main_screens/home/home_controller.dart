part of 'home_view.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  var mainControler = Get.find<MainController>();
  var dummyData = <Map<String, dynamic>>[
    {
      'id': '123',
      'date': '14 April 2025',
      'title': 'Khmer New Year 2025',
      'time': 'Sunday 10:00AM - 11:30PM',
      'image':
          'https://scontent-bkk1-1.xx.fbcdn.net/v/t39.30808-6/477724281_1173354900810321_4556768304329423266_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeH6Gy68eAtWizWZ-dKl2wCkeGCgagcq6dZ4YKBqByrp1nklxBOhi12slQJpDSRcdsQLDJmpFgKBN6UDN_zAsaYI&_nc_ohc=xaY3WhYyp58Q7kNvgERVR3K&_nc_oc=AdiPBG9ynRLo2i9vOuobcwXBwMYASy-Kdhvkh4L-ZRq-bBqRjgdxp1_eQ8f59q3gzPs&_nc_zt=23&_nc_ht=scontent-bkk1-1.xx&_nc_gid=AOyTCZzzF3UCdSPi4Aw2B6_&oh=00_AYCznj-ejsAlFzgeA1C72gNkAN1qNQ7IV3sqFVomHVQe9Q&oe=67CCE1F3',
      'member': 69,
      'firstMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
      'secondMember':
          'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
      'thirdMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
      'street': '11.568895488974254, 104.8931566395971',
      'organizer': 'neakreach 7 por',
      'organizer_profile':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdBWB76EZKUgHdARYa-XNyIzoiJiUiyKiFrg&s',
      'event_type': [
        {
          'type': 'Normal',
          'price': 5.00,
        },
        {
          'type': 'Standard',
          'price': 10.00,
        },
        {
          'type': 'VIP',
          'price': 15.00,
        },
        {
          'type': 'VVIP',
          'price': 20.00,
        },
      ],
      'contact': '012345678',
      'about_event':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'price': '20',
    },
    {
      'id': '123',
      'date': '14 April 2025',
      'title': 'Chinese New Year 2025',
      'time': 'Saturday 10:00AM - 11:30PM',
      'image':
          'https://scontent-bkk1-1.xx.fbcdn.net/v/t39.30808-6/476237547_1169887787823699_6753392613596753970_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHQ1hMzCbLaVxy3F_opiCruR0o03Au51_9HSjTcC7nX_2be11gMPaOKWfk6RCcfnmSVtkijdOIaet2GViMXwDs6&_nc_ohc=7s9lZfRzsRcQ7kNvgHljbEx&_nc_oc=AdgnFKG-I3ygUamkIyK3-A7IrcriBlivsIAX7nLQuHb1uxCm4PbKSk1h8DfjfUzmrcE&_nc_zt=23&_nc_ht=scontent-bkk1-1.xx&_nc_gid=AVivFekG7Rp0aPU4SKoHwTC&oh=00_AYAauIR_RGlS82Z81mQjD6ySNQPRy3rZ6x8ZHJLA-zfaUg&oe=67CCF74C',
      'member': 20,
      'firstMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
      'secondMember':
          'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
      'thirdMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
      'street': '11.572470871830166, 104.8933381480577',
      'organizer': 'neakreach 7 por',
      'organizer_profile':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdBWB76EZKUgHdARYa-XNyIzoiJiUiyKiFrg&s',
      'event_type': [
        {
          'type': 'Normal',
          'price': 5.00,
        },
        {
          'type': 'Standard',
          'price': 10.00,
        },
      ],
      'contact': '012345678',
      'about_event':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'price': '20',
    },
    {
      'id': '123',
      'date': '14 April 2025',
      'title': 'Khmer New Year 2025',
      'time': 'Sunday 10:00AM - 11:30PM',
      'image':
          'https://d2vr64fd62ajh5.cloudfront.net/images/cat/posters-big-2021040614.webp',
      'member': 69,
      'firstMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
      'secondMember':
          'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
      'thirdMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
      'street': '11.572470871830166, 104.8933381480577',
      'organizer': 'neakreach 7 por',
      'organizer_profile':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdBWB76EZKUgHdARYa-XNyIzoiJiUiyKiFrg&s',
      'event_type': [
        {
          'type': 'Normal',
          'price': 5.00,
        },
        {
          'type': 'Standard',
          'price': 10.00,
        },
        {
          'type': 'VIP',
          'price': 15.00,
        },
        {
          'type': 'VVIP',
          'price': 20.00,
        },
      ],
      'contact': '012345678',
      'about_event':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'price': '20',
    },
    {
      'id': '123',
      'date': '14 April 2025',
      'title': 'Khmer New Year 2025',
      'time': 'Sunday 10:00AM - 11:30PM',
      'image':
          'https://noorhanenterprise.com/wp-content/uploads/2022/06/Noorhan-Tham-1.jpg',
      'member': 69,
      'firstMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/male-fashion-model-698x1024.jpg',
      'secondMember':
          'https://models.bestmodelsagency.com/recursos/clientes/F31110A5-6133-4F2E-96A8-927FA9485371/list.jpg?v1589811317?202410081559',
      'thirdMember':
          'https://huntertalent.com.au/wp-content/uploads/2024/04/hunter-talent-male-modelling-300x422.jpg',
      'street': '11.572470871830166, 104.8933381480577',
      'organizer': 'neakreach 7 por',
      'organizer_profile':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdBWB76EZKUgHdARYa-XNyIzoiJiUiyKiFrg&s',
      'event_type': [
        {
          'type': 'Normal',
          'price': 5.00,
        },
        {
          'type': 'Standard',
          'price': 10.00,
        },
        {
          'type': 'VIP',
          'price': 15.00,
        },
        {
          'type': 'VVIP',
          'price': 20.00,
        },
      ],
      'contact': '012345678',
      'about_event':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'price': '20',
    },
  ];

  void updateScreen(int pageNumber) {
    mainControler.currentIndex.value = pageNumber;
  }
}
