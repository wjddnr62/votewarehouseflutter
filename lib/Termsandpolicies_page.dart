import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home/tabSelect.dart';
import 'Public/color.dart';



class termsandpolicies extends StatefulWidget {
  @override
  _termsandpoliciesState createState() => _termsandpoliciesState();
}

class _termsandpoliciesState extends State<termsandpolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){T_page(context);},color: black,),
        backgroundColor: Colors.white,
        title: Text('약관 및 정책',style: TextStyle(fontWeight: FontWeight.bold,color: black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: MediaQuery.of(context).size.width,padding: const EdgeInsets.only(top: 15,bottom: 10),child:Text('이용약관',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child:Text('제 1 장 총칙',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 1 조 (목적)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),),
              Text('이 약관은 서치리서치(이하 "회사")가 제공하는 투표창고 서비스(이하 "서비스")의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 2 조 (정의)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('이 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와상관없이 "회원"이 이용할 수 있는 투표창고 및 투표창고 관련 제반 서비스를 의미합니다.\n2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 이용자를 말합니다.\n3. "비회원"이라 함은 회원에 가입하지 않고 "회사"가 제공하는 "서비스"를 이용하는 자를 말합니다.\n4. “당첨자”라 함은 “회원”이 “서비스”를 통해 응모를 하고 “회사”의 추첨 프로그램에 따라 “추첨상품”을 지급 받을 사람으로 선정된 “회원”을 말합니다.\n5. "애플리케이션"이라 함은 iOS, Android 등의 모바일 운영체제에 탑재되어있는 앱스토어를통해 단말기에 설치하여 이용할 수 있도록 구성된 프로그램을 말합니다.\n6. "의뢰자"는 "회원"이 "서비스"를 통해 참여하는 조사의 의뢰 주체를 의미합니다.\n7. "아이디"라 함은 "회원"의 식별과 "서비스"이용을 위하여 "회원"이 정하고 "회사"가 승인하는문자와 숫자의 조합을 의미합니다.\n8. "비밀번호"라 함은 "회원"이 부여받은 "아이디"와 일치되는 "회원"임을 확인하고 비밀보호를위해 "회원" 자신이 정한 문자와 숫자의 조합을 의미합니다.\n9. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "회원"이 "서비스"에 게시한 문자, 문서, 그림, 음성, 링크, 파일 혹은 이들의 조합으로 이루어진 정보 등 모든 정보나 자료를 의미합니다.\n10. “추첨상품”이라 함은 “회원”이 “서비스”에 종속된 활동을 통해 부여받은 것으로, “회사” 가 ”당첨자“에게 제공하는 경품을 의미합니다.\n11. "창고머니"라 함은 "회원"이 "서비스"에 종속된 활동을 통해 부여받은 것으로, 현금으로 환급 또는 "제휴컨텐츠" 이용에 사용할 수 있는 가상의 화폐를 의미합니다.\n12. "제휴컨텐츠"라 함은 "회사"가 제휴를 통하여 "회원"이 "창고머니"를 지급하고 사용할 수있는 다양한 서비스를 의미합니다.\n13. “마이정보”라 함은 “회원”이 “서비스”에 입력한 회원정보를 의미합니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 3 조 (약관의 명시와 개정)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"는 이 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 초기 화면(전면)에 게시합니다.\n2. "회사"는 "약관의 규제에 관한 법률", "정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 "정보통신망법")" 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.\n3. "회사"는 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 사이트의초기화면에 그 적용일 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이경우 "회사"는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.\n4. "회사"가 개정약관을 공지 또는 통지하면서 "회원"에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 고지하였음에도 "회원"이 명시적으로 거부의 의사표시를 하지 아니한 경우, "회원"이 개정약관에 동의한 것으로 봅니다.\n5. "회원"이 개정약관의 적용에 동의하지 않는 경우 "회사"는 개정 약관의 내용을 적용할 수없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는특별한 사정이 있는 경우에는 "회사"는 이용계약을 해지할 수 있습니다.\n6. 본 약관에서 명시하지 않은 사항과 본 약관의 해석에 관하여는 관계법령 또는 상관례에 따릅니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 2 장 총칙 서비스 계약의 체결',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 4 조 (서비스 이용계약 체결)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "서비스" 이용계약은 아래의 방법으로 체결이 가능합니다.\n1) "회원"이 되고자 하는 자(이하 "가입신청자")가 이용약관에 동의를 하고 "회사"에서 요구하는정보를 입력한 경우 "회사"가 이러한 신청에 대하여 승낙함으로써 체결됩니다.\n2. "회사"는 다음 각 호에 해당하는 신청에 대하여 승낙을 하지 않거나, 사후에 통보 없이 이용계약을 해지할 수 있습니다.\n1)가입신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우 (다만, 회원자격상실 후 1년이 경과한 자로서 "회사"의 회원 재가입 승낙을 얻은 경우에는 예외로 함)\n2) 실명이 아니거나 타인의 명의를 이용한 경우\n3) 허위의 정보를 기재하거나, "서비스"에서 제시하는 내용을 기재하지 않은 경우\n4) 가입신청자가 만 14세 미만 아동인 경우\n5) 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우\n3. 제1항에 따른 신청에 있어 "회사"는 "회원"의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.\n4. "회사"는 "서비스" 관련 설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는승낙을 유보할 수 있습니다.\n5. 제2항과 제4항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, "회사"는 원칙적으로 이를 “가입신청자”에게 알리도록 합니다.\n6. 이용계약의 성립 시기는 "회사"가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.\n7. "회사"는 "회원"에 대해 회사정책에 따라 등급별로 구분하여 이용시간, 이용횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 5 조 (회원정보의 변경)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회원"은 개인정보관리화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, "서비스" 관리를 위해 필요한 실명, 아이디 등은 수정이 불가능합니다.\n2. "회원"은 회원가입신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 "회사"에 대하여 그 변경사항을 알려야 합니다.\n3. 제2항의 변경사항을 "회사"에 알리지 않아 발생한 불이익에 대하여 "회사"는 책임지지 않습니다.\n4. "회원"은 언제든지 서비스 초기화면의 고객센터 또는 내 정보 관리 메뉴 등을 통하여 이용계약 해지 신청(회원탈퇴)을 할 수 있습니다. "회원"이 회원탈퇴를 신청한 경우 회사는 회원본인 여부를 확인할 수 있으며, 관계법규 등이 정하는 바에 따라 이를 즉시 처리합니다. 단, " 회사"는 서비스 운영 원칙에 따라 30일 동안 재가입을 제한할 수 있습니다.\n5. "회원"이 계약을 해지할 경우, 관련법 및 개인정보취급방침에 따라 "회사"가 회원정보를 보유하는 경우를 제외하고는 해지 즉시 "회원"의 모든 데이터는 소멸됩니다.\n6. "회원"이 연속하여 일 년 동안 서비스에 log-in한 기록이 없는 경우 회원 자격을 상실할수 있습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 6 조 (개인정보보호 의무)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('"회사"는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 "회원"의 개인정보를 보호하기 위해노력합니다. 개인정보의 보호및 사용에 대해서는 관련법 및 "회사"의 개인정보취급방침이 적용됩니다. 다만, "회사"의 공식 사이트 이외의 링크된 사이트에서는 "회사"의 개인정보취급방침이 적용되지 않습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 7 조 ("회원"의 "아이디" 및 "비밀번호"의 관리에 대한 의무)',textAlign: TextAlign.left,),),
              Text('1."회원"의 "아이디"와 "비밀번호"에 관한 관리책임은 "회원"에게 있으며, 이를 제3자가 이용하도록 하여서는 안됩니다.\n2."회사"는 "회원"의 "아이디"가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나, "회사" 및 "회사"의 운영자로 오인한 우려가 있는 경우, 해당 "아이디"의 이용을 제한할 수 있습니다.\n3. "회원"은 "아이디" 및 "비밀번호"가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는이를 즉시 "회사"에 통지하고 "회사"의 안내에 따라야 합니다.\n4. 제3항의 경우에 해당 "회원"이 "회사"에 그 사실을 통지하지 않거나, 통지한 경우에도 "회사"의 안내에 따르지 않아 발생한 불이익에 대하여 "회사"는 책임지지 않습니다. '),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 8 조 ("회사"의 의무)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화, 용역을 제공하는 데 최선을 다하여야 합니다.\n2. "회사"는 이용자가 안전하게 "서비스"를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어 이용자의 개인정보보호에 최선을 다하여야 합니다.\n3. "회사"는 판매하는 상품이나 용역에 대하여 <표시. 광고의공정화에관한법률> 제3조의 규정에 위반하는 표시 및 광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 부담합니다.\n4. "회사"는 수신거절의 의사를 명확히 표시한 이용자에 대해서는 영리목적의 광고성 문자메시지 및 전자우편을 발송하지 않습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 9 조 ("회원"의 의무)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회원"은 다음 행위를 하여서는 안 됩니다.\n1) 개인정보의 등록(변경의 경우 포함함)시 허위내용을 등록\n2) 의도적으로 동시에 두 개 이상의 계정을 사용\n3)"회사"에 게시된 정보를 임의로 변경\n4) "회사"가 허락하지 않은 정보(컴퓨터 프로그램 등)의 송신 또는 게시\n5) "회사" 기타 제3자의 저작권 등 지적재산권에 대한 침해\n6) "회사" 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위\n7) 외설 또는 폭력적인 메시지, 화상, 음성 기타 공서양속에 반하는 정보를 화면에 공개 또는게시하는 행위\n8) 불특정 다수의 자를 대상으로 "회사"의 "서비스"를 이용하여 영리목적으로 활동하는 행위\n9) 사실관계를 왜곡하는 정보제공 행위, 기타 "회사"가 부적절하다고 판단하는 행위\n10) 타인의 정보 도용\n\n2."회원"은 관계법, 이 약관의 규정, 이용안내 및 "서비스"와 관련하여 공지한 주의사항, "회사"가 통지하는 사항 등을 준수하여야 하며,기타 "회사"의 업무에 방해되는 행위를 하여서는 안됩니다.\n만약 이를 위반할 경우 회원자격이 박탈될 수 있습니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 3 장 서비스의 내용과 이용',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 10 조 ("서비스"의 내용)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('"회사"는 "회원"에게 아래와 같은 서비스를 제공합니다. 1. "회사"는 "회원"에게 아래와 같은 서비스를 제공합니다.\n1) 설문조사에 대해 응답할 수 있는 자격과 이에 따른 “추첨상품” 및 "창고머니" 제공\n2) "창고머니"를 현금으로 환급 또는 "제휴컨텐츠"로 교환\n3) 이외 제공하는 모든 부가 서비스'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 11 조 ("서비스"의 이용)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"는 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시공지합니다. 단, "회사"가 합리적으로 예측할 수 없는 불가피한 여건이나 사정이 있는 경우, 위 공지기간을 단축할 수 있습니다.\n2. "회사"가 제공하기로 이용자와 계약을 체결한 "서비스"의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시통지합니다.\n3. 전항의 경우 "회사"는 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, "회사"가 고의또는 과실이 없음을 입증하는 경우에는 아무런 책임을 부담하지 않습니다. "회사"는 컴퓨터 등정보통신설비의 보수점검, 교체 및 고장, 통신두절 또는 운영상 상당한 이유가 있는 경우 "서비스"의 제공을 일시적으로 중단할 수 있습니다. 다만, "회사"가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.\n4. "회사"는 서비스의 제공에 필요한 경우 정기점검을 실시할 수 있으며, 정기점검시간은 서비스제공화면에 공지한 바에 따릅니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 12 조 ("서비스"의 변경)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 "서비스"를 변경할 수 있습니다.\n2. "서비스"의 내용, 이용방법, 이용시간에 대하여 변경이 있는 경우에는 변경사유, 변경될 서비스의 내용 및 제공일자 등은 그 변경 전에 미리 내용을 초기화면에 게시하여야 합니다.\n3. "회사"는 무료로 제공되는 "서비스"의 일부 또는 전부를 "회사"의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 "회원"에게 별도의보상을 하지 않습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 13 조 (정보의 제공 및 광고의 게재)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"는 "회원"이 "서비스" 이용 중 필요하다고 인정되는 다양한 정보를 공지사항, 전자우편 등의 방법으로 "회원"에게 제공할 수 있습니다. 다만, "회원"은 관련법에 따른 거래관련 정보 및 고객문의 등에 대한 답변 등을 제외하고는 언제든지 전자우편 등에 대해서 수신 거절을할 수 있습니다.\n2. 제1항의 정보를 전화 및 팩스전송기기에 의하여 전송하려고 하는 경우에는 "회원"의 사전동의를 받아서 전송합니다. 다만, "회원"의 “추첨상품” 지급, 거래관련 정보, 고객문의 등에 대한 회신에 있어서는 제외됩니다.\n3. "회사"는 "서비스"의 운영과 관련하여 "서비스" 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있습니다. 광고가 게재된 전자우편 등을 수신한 "회원"은 수신거절을 "회사"에게 할 수있습니다.\n4. "회원"의 정보는 "의뢰자"에게 아래와 같은 기준에 의해 제공됩니다.\n1) "회원"이 참여한 설문조사의 결과에 대한 통계 조사 자료로만 활용되며,이 과정에서 개인을 식별할 수 있는 실명 등의 정보는 제공되지 않습니다.\n2) "회원"에 대하여 "의뢰자"가 인터뷰 또는 개별 연락을 원할 경우, "회원"과 "회사"의 동의 하에 모든 과정이 진행됩니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 14 조 (“당첨자” 선정 및 “추첨상품” 지급 관련)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "당첨자”는 “회사”가 정한 소정절차에 따라 상품을 지급 받을 수 있습니다.\n1) “회사”는 “당첨자” 내역을 일정 시간 동안 “서비스” 내에 게시한 후, “당첨자”가 마이정보에 입력한 연락처로 개별 연락을 드립니다.\n2) “당첨자”에게 4차례의 연락을 통해 연결이 되지 않을 경우, 당첨이 자동 취소되므로 마이정보에 자신의 연락처를 정확히 입력하시는 것을 권장드립니다.\n3) "추첨상품"의 지급에 따라 발생하는 제세공과금은 "당첨자"가 부담합니다.\n4) “추첨상품” 배송 지연이나 “추첨상품” 수취 시 정부에서 부과하는 지방세에 대해 “회사”는책임지지 않습니다.\n5) “추첨상품:에 대한 소득신고 및 법령에 의한 제세공과금 부담을 위해 ”당첨자“는 신분증사본을 지정된 연락처로 전송해야 합니다.\n6) "추첨상품“이 기프트콘일 시 해당 바코드가 ”당첨자“가 마이정보에 기재한 연락처로 전송됨으로써 적법하게 지급한 것으로 봅니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 15 조 ("회원"의 "창고머니" 환급 관련 정책)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "창고머니"를 10,000원 이상 보유한 "패널"은 보유한 "창고머니"의 현금환급을 신청 할 수있습니다. "회사"가 정한 소정절차에 따라 "창고머니"를 현금으로 환산한 금액을 지급 받을 수있으며, 이 경우 "회사"는 "회원"이 지정하는 은행계좌에 상기 금액을 입금함으로써 적법하게지급한 것으로 봅니다.\n2. "창고머니"의 사용 및 현금환급과 관련하여 "창고머니"는 일 창고머니(1 창고머니)당 일 원(1 원)으로 환산함을 원칙으로 합니다.\n3. "창고머니"의 현금환급에 따라 발생하는 제세공과금은 "회원"이 부담합니다.\n4. "회사"의 "제휴컨텐츠"를 "창고머니"로 구매 시 해당 바코드가 전송됨으로써 적법하게 지급한 것으로 봅니다.\n5. "회원"은 "창고머니"를 타인에게 양도하거나 대여 또는 담보의 목적으로 이용할 수 없습니다. 다만, "회사"가 인정하는 적법한 절차를 따른 경우는 예외로 합니다.\n6. "창고머니"를 사용할 경우, 먼저 적립 된 "창고머니"가 먼저 사용됩니다.\n7. "회원"에게 지급된 "창고머니"의 유효기간은 3년으로 하며, 3년의 유효기간이 지난 “창고머니"는 자동적으로 소멸됩니다. 다만 "창고머니"의 자동소멸은 2020년 3월 1일 이후 발생한 "창고머니"에 한해 적용됩니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 16 조 ("서비스" 권리의 귀속 및 "게시물"의 이용)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회원"의 "게시물"이 "정보통신망법" 및 "저작권법"등 관련법에 위반되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 "게시물"의 게시중단 및 삭제 등을 요청할 수있으며, "회사"는 관련법에 따라 조치를 취하여야 합니다.\n2. "회사"는 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사 정책 및 관련법에 위반되는 경우에는 관련법에 따라 해당 "게시물"에 대해 임시조치 등을 취할 수 있습니다.\n3. "서비스"에 대한 저작권 및 지적재산권은 "회사"에 귀속됩니다. 단, 제휴계약에 따라 제공된저작물 등은 제외합니다.\n4. "회사"는 서비스와 관련하여 "회원"에게 "회사"가 정한 이용조건에 따라 "아이디", 콘텐츠, ” 추첨상품“, "창고머니" 등을 이용할 수 있는 이용권만을 부여하며, "회원"은 이를 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다. '),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 17 조 ("애플리케이션"의 이용)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회원"은 모바일 단말기 제조사 및 이동통신사에서 제공하는 앱스토어를 통해 "애플리케이션"을 설치하여 "서비스"를 이용할 수 있습니다.\n2. "회원"이 "서비스"의 일부 또는 이용규칙을 적용하는 데에 사용되는 보안 기술이나 소프트웨어를 회피 또는 변경하려 시도를 하거나 부정 사용 및 타인이 그렇게 하는 것을 조장하는행위 등은 금지되어 있으며, 만약 "회원"이 그와 같은 행위를 하는 경우 이에 대한 모든 책임은 "회원" 본인에게 있습니다.'),


              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 4 장 기타',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 18 조 (책임제한)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. ”회사"는 천재지변 또는 이에 준하는 불가항력으로 인하여 "서비스"를 제공할 수 없는 경우에는 "서비스" 제공에 관한 책임이 면제됩니다.\n2. "회사"는 "회원"의 귀책사유로 인한 "서비스" 이용의 장애에 대하여는 책임을 지지 않습니다.\n3. "회사"는 무료로 제공되는 "서비스" 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 19 조 (준거법 및 재판관할)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('1. "회사"와 "회원" 간 제기된 소송은 대한민국법을 준거법으로 합니다. 2. "회사"와 "회원"간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다.'),
              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('제 20 조 (사업자 정보)',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Container(width: MediaQuery.of(context).size.width,child:Text('1. 회사명: 서치리서치\n2. 대표자: 윤정상, 황유진\n3. 개인정보관리 책임자: 황유진\n4. 주소:  \n5. 대표전화:',textAlign: TextAlign.left,),),



              Container(padding: const EdgeInsets.only(top: 40),width: MediaQuery.of(context).size.width,child:Text('[부칙]',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),),
              Text('1. 이 약관은 2020년 3월 1일부터 시행합니다.\n 2. 제 9 조 ("회원"의 의무) 약관은 2020년 3월 1일부터 적용됩니다.\n\n\n'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('개인정보취급방침',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('"서치리서치" 는 (이하 "회사"는) 회원님의 개인정보를 안전하게 보호하기 위하여 최선의 노력을 다하고 있으며, "정보통신망 이용촉진 및 정보보호 등에 관한 법률”과 “개인정보 보호법”등 개인정보와 관련된 법령 상의 규정들과 방송통신위원회 및 미래창조과학부, 안전행정부 등의 유관기관이 제정한 가이드라인을 준수하고 있습니다. 회사는 개인정보취급방침을 통하여 회원님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를위해 어떠한 조치가 취해지고 있는지 알려드립니다. 개인정보취급방침은 정부의 법령이나 지침의 변경이나, 보다 나은 서비스의 제공을 위하여 그 내용이 변경될 수 있습니다. 이 경우회사는 웹 사이트에서 공지사항에 이를 올리거나 이메일을 통해서 공지하고 있습니다. 회원님께서는 개인정보 취급방침이 홈페이지 첫 화면의 맨 아래에 표시되어 있으니, 수시로 확인해주실 것을 부탁 드립니다.\n'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('1. 수집하는 개인정보의 항목 및 수집방법',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('수집하는 개인정보의 항목 첫째, 회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 최소한의 개인정보를 필수항목으로 수집합니다.\n\n1. 회원가입 - 이름, 생년월일, 이메일주소, 비밀번호, 전화번호, 성별, 연령대, 사는 지역\n2. 추첨상품 및 창고머니 획득 - 주택 형태, 주택 소유 형태, 최종학력, 결혼유무, 가족 구성원 수, 사용하는 통신사, 정치 성향, 직업, 소득 수준, 자동차 보유 유무둘째, 회원이 부가 서비스 및 맞춤식 서비스 등을 이용하는 과정에서 해당 서비스의 이용자에한해서만 추가 정보들이 수집될 수 있습니다. - "투표창고 플레이스" 참여자의 방문 기록(위치 정보) 수집에 대한 동의를 받는 경우 - 그 외 필요한 개인정보 추가 수집에 대해 동의를 받는 경우셋째, 서비스 이용과정이나 사업처리 과정에서 아래의 정보가 자동으로 생성되어 수집될 수있습니다. - 서비스 이용 기록, 접속 로그, 결제 기록, 기기 고유번호(디바이스 아이디 또는 IMEI), 광고식별자(IDFA 또는 AAID)넷째, 적립된 포인트의 환급 과정에서 아래와 같은 결제 정보들이 수집될 수 있습니다. - 현금환급 상품 구매시: 은행명, 계좌번호 등단, 이 밖에 설문조사의 집단적인 통계분석을 위해서나 추첨상품 발송을 위한 목적으로 이용자의 개인정보를 추가 수집하는 경우 반드시 사전에 이용자에게 해당 사실을 알리고 동의를거치겠습니다. 더불어 이때 기입하신 정보는 해당 서비스의 제공이나 회원님께 사전에 밝히 목적 이외의 다른 어떠한 목적으로도 사용되지 않습니다. 나. 개인정보 수집방법회사는 다음과 같은 방법으로 개인정보를 수집합니다.\n- 홈페이지\n- 스마트폰 어플리케이션\n- 제휴사로부터의 제공\n- 생성정보 수집 툴을 통한 수집'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('2. 개인정보의 수집 및 이용목적',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사가 개인정보를 수집하는 목적은 이용자의 신분과 서비스 이용 의사를 확인하여 최적화되고 맞춤화된 서비스를 제공하기 위함입니다. \n회사는 최초 회원가입 시 서비스 제공을 원활하기 하기 위해 필요한 최소한의 정보만을 수집하고 있으며 회사가 제공하는 서비스 이용에 따른 요금 정산, 회원 관리, 마케팅 및 환불 등에 필요한 정보를 추가로 수집할 수 있습니다. \n회사는 개인정보를 수집, 이용 목적 이외에 다른 용도로 이를 이용하거나 이용자의 동의 없이 제3자에게 이를 제공하지 않습니다. 회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 통계학적 특성에 따른 설문조사 정보제공, 맞춤 서비스 제공, 본인인증, 추첨상품 및 포인트지급, 현금 환급\n\n나. 회원 관리 회원제 서비스 이용에 따른 본인 확인, 개인 식별 및 차등화된 서비스 제공, 불량 회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 연령 확인 및 맞춤 서비스 제공\n\n다. 마케팅 및 광고에 활용 신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스의 유효성 확인, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속빈도 파악, 회원의 서비스이용에 대한 통계'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('3. 개인정보의 보유 및 이용 기간',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('가. 원칙적으로 개인정보는 회사가 회원에게 서비스를 제공하는 기간 동안에 한하여 보유 및이용됩니다. 따라서 회원 탈퇴 시 회사가 보유한 개인 정보가 삭제되는 것을 원칙으로 합니다. 단 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다. - 회원의 이메일주소 (회원 탈퇴 후 30일간 재가입 방지 목적): 30일 - 회원의 부정 이용에 대한 조치이력 (회원의 악의적 이용의 재발 방지를 위한 목적): 6개월 - 은행명, 계좌번호, 계좌주 (포인트 현금 환급 과정에서 발생하는 고객 문의에 대한 과거 신청 내역 확인 목적): 지급일이 포함된 달부터 6개월\n나. 관계 법령의 규정에 의해 보존할 필요성이 있는 경우 회사는 관계법령에서 정한 기간 이상 이용자의 개인정보를 보관할 수 있습니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며, "보존 근거"에서 명시한 근거에 따라 "보존 기간" 동한 보존한 후 파기합니다. - 방문에 관한 기록 : 3개월(통신비밀보호법)'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('4. 개인정보의 파기절차 및 방법',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.\n파기절차 및 방법은 다음과 같습니다.\n가. 파기절차회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어 집니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.나. 파기방법- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('5. 개인정보 제공',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사는 이용자의 개인정보를 개인정보취급방침의 “개인정보의 수집 및 이용 목적”에서 고지한범위 또는 서비스 이용약관에 명시한 범위 내에서만 사용하며, 동 범위를 넘어 이용하거나 제3자에게 제공하지 않습니다.\n단, 다음의 경우 주의를 기울여 개인정보를 이용하거나 제 3자에게 제공할 수 있습니다.\n가. 이용자들이 사전에 동의한 경우정보 수집 및 제공을 위하여 이용자가 자발적으로 자신의 개인정보를 제 3자에게 제공하는 것에 동의한 경우를 뜻하며, 이러한 경우에도 회사는 이용자에게\n(1) 개인정보를 제공받는 자,\n(2) 그의 이용목적,\n(3) 제공되는 개인정보의 항목,\n(4) 개인정보의 보유 및 이용기간을 사전에고지하고 이에 대해 명시적·개별적으로 동의를 얻습니다. 이와 같은 모든 과정에 있어서 회사는 이용자의 의사에 반하여 추가적인 정보를 수집하거나, 동의의 범위를 벗어난 정보를 제3자와 공유하지 않습니다.\n\n나. 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의요구가 있는 경우'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('6. 개인정보의 취급위탁',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사는 서비스 향상을 위해서 아래와 같이 개인정보를 위탁하고 있으며, 관계 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 회사의 개인정보 위탁처리 기관 및 위탁업무 내용은 아래와 같습니다\n'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('수탁업체위탁업무 내용 개인정보의 보유 및 이용기간',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),),
              Text('(주)케이지이니시스 신용카드 결제, 계좌이체 결제 서비스 제공기간 종료시까지\n(주)LG U+ 문자메세지 발송 서비스 제공기간 종료시까지\n(주)케이티엠하우스\n(대리인:(주)퍼니에이드) 기프티쇼 서비스 운영 및 대행, 시스템 구축 및 유지보수, 기프티쇼 서비스 이용 관련 상담업무 서비스 제공기간 종료시까지'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('7. 이용자 및 법정대리인의 권리와 그 행사방법',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('- 이용자 본인 및 법정대리인은 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다. - 본 서비스는 만 14세 미만인 아동의 회원가입이 불가합니다. 이용자의 개인정보 조회 및 수정을 위해서는 ‘개인정보변경’(또는 ‘회원정보수정’ 등)을, 가입 해지(동의철회)를 위해서는 “회원탈퇴”를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다. 혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다. - 귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지해 정정이 이루어지도록 하겠습니다. - 회사는 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 “회사가 수집하는 개인정보의 보유 및 이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('8. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사는 귀하의 정보를 수시로 저장하고 찾아내는 ‘쿠키(cookie)’ 등을 운용합니다. 쿠키란 웹사이트를 운영하는데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서귀하의 컴퓨터 하드디스크에 저장됩니다. 회사는 다음과 같은 목적을 위해 쿠키를 사용합니다.\n\n가. 쿠키 등 사용 목적- 회원과 비회원의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤서비스 제공 귀하는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 귀하는 웹 브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나 쿠키가 저장될 때마다 확인을 거치거나 아니면 모든 쿠키의 저장을 거부할 수도 있습니다.\n\n나. 쿠키 설정 거부 방법 예: 쿠키 설정을 거부하는 방법으로는 회원님이 사용하시는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다. 설정방법 예(인터넷 익스플로어의 경우): 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보단 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('9. 개인정보의 기술적/관리적 보호 대책',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('회사는 이용자들의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적/관리적 대책을 강구하고 있습니다.\n\n가. 비밀번호 암호화 아이디(ID)의 비밀번호는 암호화되어 저장 및 관리되고 있어 본인만이 알고 있으며 개인정보의 확인 및 변경도 비밀번호를 알고 있는 본인에 의해서만 가능합니다.\n\n나. 해킹 등에 대비한 대책회사는 해킹이나 컴퓨터 바이러스 등에 의해 회원의 개인정보가 유출되거나 훼손되는 것을 막기 위해 최선을 다하고 있습니다. 개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고최신 백신프로그램을 이용하여 이용자들의 개인정보나 자료가 누출되거나 손상되지 않도록 방지하고 있으며 암호화 통신 등을 통하여 네트워크상에서 개인정보를 안전하게 전송할 수 있도록 하고 있습니다. 그리고 침입차단 시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있으며 기타 시스템적으로 보안성을 확보하기 위한 가능한 모든 기술적 장치를 갖추려 노력하고 있습니다.\n\n다. 취급 직원의 최소화 및 교육회사의 개인정보관련 취급 직원은 담당자에 한정시키고 있고 이를 위한 별도의 비밀번호를 부여하여 정기적으로 갱신하고 있으며 담당자에 대한 수시 교육을 통하여 개인정보취급방침의준수를 항상 강조하고 있습니다.'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('10. 개인정보에 관한 민원서비스',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('- 회사는 회원의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서를 지정하고 있습니다. - 귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보 관리책임자 혹은 담당부서로 신고하실 수 있습니다. 회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.\n\n'),
              Text('[개인정보보호 관련 담당부서]\n- 부서명: 투표창고\n- 고객센터 \n- 전화번호: \n- 이메일: \n기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 개인정보위탁업체 NICE 신용평가정보나 아래 기관에 문의하시기 바랍니다.\n- NICE 신용평가정보 www.nicecredit.com/02-2122-4000)\n- 개인정보침해신고센터 (www.1336.or.kr/국번없이 118)\n- 정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4)\n- 대검찰청 인터넷범죄수사센터 (icic.sppo.go.kr/2-3480-3600)\n- 경찰청 사이버테러대응센터 (www.ctrc.go.kr/02-392-0330)'),

              Container(padding: const EdgeInsets.only(top: 10),width: MediaQuery.of(context).size.width,child:Text('11. 정책변경에 따른 공지',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),),
              Text('가. 본 개인정보취급방침은 홈페이지 첫 화면에 공개함으로써 회원님께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.\n나. 법령 정책 또는 보안기술의 변경에 따라 내용의 추가 삭제 및 수정이 있을 시에는 변경되는 개인정보취급방침을 시행하기 전에 홈페이지를 통해 변경이유 및 내용 등을 공지하도록 하겠습니다.\n다. 본 개인정보취급방침의 내용은 수시로 변경될 수 있으므로 사이트를 방문하실 때마다, 이를 확인하시기 바랍니다.\n'),

              Container(width: MediaQuery.of(context).size.width,child:Text('- 공고일자: 2020년 3월 1일\n- 시행일자: 2020년 3월 1일',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(bottom: 5),),

            ],
          ),
        ),
      ),

    );
  }

  void T_page(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabSelect(2)), (Route<dynamic> route)=>false);
  }


}

