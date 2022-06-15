import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:base_lib/all.dart';
import 'camera_word_b.dart';

class CameraWordA extends StatefulWidget {
  const CameraWordA({ Key? key, required this.fnAfterTakePhoto }) : super(key: key);
  final Function fnAfterTakePhoto;

  @override
  _CameraWordAState createState() => _CameraWordAState();
}

class _CameraWordAState extends State<CameraWordA> {
  bool _isOk = false;       //state variables

  //input fields
  CameraController? cameraCtrl;
  
  String _flashType = 'A';  //default auto

  //flash type list
  final List<IdStrDto> _flashTypeList = [
    IdStrDto(id:'A', str:'自動'),
    IdStrDto(id:'1', str:'開啟'),
    IdStrDto(id:'0', str:'關閉'),
  ];
  //flash icon list
  final Map<String, IconData> _flashIcon = {
    'A': Icons.flash_auto,
    '1': Icons.flash_on,
    '0': Icons.flash_off
  };


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()=> showAsync());
  }

  @override
  void dispose() {
    if (cameraCtrl != null) cameraCtrl!.dispose();

    super.dispose();
  }

  Future showAsync() async {
    //initial camera
    var cameras = await availableCameras();
    if(cameras.isEmpty){
      ToolUt.msg(context, 'No Camera !!');
    } else {
      cameraCtrl = CameraController(cameras[0], ResolutionPreset.max);            
      cameraCtrl!.initialize().then((_) {
        if (mounted) {
          _isOk = true;
          setState((){});          
        }        
      });
    }        
  }

  /// 設定閃光燈模式
  void setFlashMode(String type){
    var mode = (type == 'A') ? FlashMode.auto :
      (type == '1') ? FlashMode.always :
      FlashMode.off;
    cameraCtrl!.setFlashMode(mode);
  }

  /// 下拉式欄位 for 閃光燈
  Widget iselect2(String value, IconData icon, List<IdStrDto> rows, Function fnOnChange){
    return Padding(
      padding: const EdgeInsets.only(left:10),
      child: DropdownButton(
        value: value,
        //icon: const Icon(Icons.flag),
        icon: Icon(icon, color: Colors.blue),
        style: const TextStyle(fontSize:18, color: Colors.blue),
        items: rows.map((IdStrDto row) {
          return DropdownMenuItem<String>(
            child: Text(row.str),
            value: row.id,
          );
        }).toList(),
        onChanged: (value2)=> fnOnChange(value2),
    ));
  }

  /// 拍照或選取圖片時寫入文字
  /// param context : 相機預覽畫面
  Future onTakePhotoAsync() async {
    //copy to temp photo
    var file = await cameraCtrl!.takePicture();
    //await File(file.path).copy(Xp.tempPhoto);

    //關閉相機預覽
    ToolUt.closeForm(context);

    //開啟另一個 dialog
    ToolUt.openForm(context, CameraWordB(
      imagePath: file.path, fnAfterTakePhoto: widget.fnAfterTakePhoto));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOk) return Container();

    return Material(child: Stack(
      children: [
        //解決影像失真的問題
        MaterialApp(home: CameraPreview(cameraCtrl!)),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WG.elevBtn('拍照', ()=> onTakePhotoAsync()),
                  WG.gap2(),
                  SizedBox(
                    width: 80,
                    child: iselect2(_flashType, _flashIcon[_flashType]!, _flashTypeList, (value){
                      setFlashMode(value);
                      setState(() { _flashType = value; });
    }))])))]));
  }

} //class