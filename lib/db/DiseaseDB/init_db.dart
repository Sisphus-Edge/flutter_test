// 文件路径: lib/db/init_db.dart
import 'package:flutter/material.dart';
import 'package:untitled/db/DiseaseDB/db_manager.dart';
import 'package:drift/drift.dart' as drift;

Future<void> initializeDatabase() async {
  final db = DBManager();

  // 部门数据
  final departments = [
    '内科', '外科', '肿瘤科', '皮肤科', '眼科', '神经科'
  ];


  // 检查并插入部门数据
  for (var deptName in departments) {
    final existingDepartment = await db.getDepartmentByName(deptName);
    if (existingDepartment == null) {
      await db.addDepartment(DepartmentsCompanion.insert(departmentName: deptName));
    }
  }


  print("部门数据插入完成");

  // 疾病数据
  final diseases = [
    {
      'name': '湿疹',
      'departmentName': '皮肤科',
      'description': '狗狗湿疹指的是狗狗表皮及真皮层炎症而出现的一类皮肤病变，症状是丘疹、红斑、痂皮、水疱、靡烂等皮肤伤，并且伴有热、痛、痒等症状，并且狗狗会十分瘙痒。严重情况下会导致皮肤化脓性炎症，也就是常说的脓皮症。',
      'imageUrl': 'assets/diseaseDetail/eczema.jpg', // 假设图片已经被添加到项目的资源目录
      'symptoms':'1:皮肤出现丘疹、红斑、痂皮、水疱、靡烂等皮肤伤，并有热、痛、痒症状。2患部呈点状或形状不同的红斑性湿疹，狗身体瘙痒情况严重。3:丘疹期、水疱期、脓疱期、糜烂期等不同症状。在脓疱期和糜烂期时，皮肤散有异常臭味。4:狗的背部或四肢皮肤增厚、脱屑、色素沉着、被毛粗硬、逆立、瘙痒加剧，病情反复发作，有时拖延几年。',
      'cause':'皮肤表皮细胞因过敏物质引起的炎症反应。',
      'treatment':'1先把长疮的地方毛剪掉，用白猫清凉油和地塞米松颗粒研磨的粉混在一起。给狗狗擦拭，一天一次，如果严重就一天两次。这个方法没什么副作用2：患部剪毛后在皮肤上涂肤轻松或皮炎平软膏。防止皮肤感染，也可与红霉素软膏交替涂抹。3：如果在脓胞发炎期间，可用庆大霉素、青霉素肌肉注射，防止感染。症状较重的病例，可和地塞米松注射液混合肌肉注射，每天2次。',
      'prevention':'预防远远重要于治疗，所以，我们日常也应该养成以下3条好习惯，就不用担心：1、每次洗澡或者下雨天带狗溜达后，一定要用吹风机等把狗狗的毛发吹干，吹透。毕竟，湿润的环境会更容易滋养细菌。2、在天气好的时候，多带狗狗晒晒太阳，补补钙，可以提升狗狗免疫力。3、定期给狗狗体内外驱虫，除去异物可以预防湿疹。',
      'diagnosis':'不清楚',
      'care':'不清楚',
    },
    {
      'name': '肠胃炎',
      'departmentName': '内科',
      'description': '狗狗肠胃炎是一种常见病症，通常包含腹泻，而且可能伴随呕吐。肠胃炎也可能出血，称为出血性肠胃炎(HGE) 或急性出血性腹泻症候群(AHDS)。',
      'imageUrl': 'assets/diseaseDetail/Gastroenteritis.png', // 假设图片已经被添加到项目的资源目录
      'symptoms':'症状：狗狗的肠胃炎通常会先出现软便，然后逐渐变稀。接着你可能在它的粪便中发现黏液，而狗狗排便可能需要用力，及/或忍不住在家中排便。以下是其他常见症状：1、大量排便及/或频繁排便。2、焦油状便。3、大量水样粪便。4、粪便中有血液',
      'cause':'1、吃到腐败食物或生食，或食物以外的东西。2、病毒(微小病毒、犬瘟热等)。3、肠道寄生虫。4、肠内菌丛改变。5、食物过敏或敏感。',
      'treatment':'狗狗拉稀，都是因为病毒要吃抗生素。一般狗狗产生拉稀、消化不良、中轻度肠胃炎的现象，主人可以在宠物用品商城购买一些益生菌片来调理肠胃的菌群，利用杀灭有害菌，促进狗狗肠胃并恢复健康。拉稀期间，禁止喂食，不然拉肚子会更加严重。先禁食一天，给狗狗饮用水。一天后如若未能好转，就及时送医就诊。发病后期（恢复期），在不限饮水的同时，要喂食一些营养好、易消化吸收的食物。可以在宠物用品商城选购一些益生菌、羊奶粉，帮助其快速补充体内能量。',
      'prevention':'为了预防狗狗肠胃炎的发生，主人可以从饲养管理、饮食均衡、合理运动等方面着手。 定期带狗狗去兽医处进行体检，确保其免疫系统健康，加强锻炼，提高身体素质。 另外，主人还应该留意狗狗的饮食卫生，避免给狗狗喂食过期或变质食物，保持饮水清洁，避免细菌感染。',
      'diagnosis':'不清楚',
      'care':'不清楚',
    },
  ];

  // 插入疾病数据，包括所有新增字段
  for (var disease in diseases) {
    final department = await db.getDepartmentByName(disease['departmentName'] as String);
    if (department != null) {
      await db.addDisease(DiseasesCompanion(
        diseaseName: drift.Value(disease['name']!),
        departmentID: drift.Value(department.departmentID),
        description: drift.Value(disease['description']),
        imageUrl: drift.Value(disease['imageUrl']),
        symptoms: drift.Value(disease['symptoms']),
        cause: drift.Value(disease['cause']),
        treatment: drift.Value(disease['treatment']),
        prevention: drift.Value(disease['prevention']),
        diagnosis: drift.Value(disease['diagnosis']),
        care: drift.Value(disease['care']),
      ));
    }
  }


  print("疾病数据插入完成");
}
