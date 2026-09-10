import 'package:flutter/material.dart';
void main() {
  runApp(const AICruiseApp());
}
class AICruiseApp extends StatelessWidget {
  const AICruiseApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Cruise',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  bool isRunning = false;
  void startCruise() {
    setState(() {
      isRunning = true;
    });
  }
  void stopCruise() {
    setState(() {
      isRunning = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080811),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D18),
        elevation: 0,
        title: const Text(
          'AI Cruise',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 15),
            // الشعار
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Colors.cyanAccent,
                    Colors.purpleAccent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.25),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF111120),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  size: 55,
                  color: Colors.cyanAccent,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'AI Cruise',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'المساعد الذكي الشخصي',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 22),
            // حالة النظام
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF11111D),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isRunning
                      ? Colors.greenAccent.withOpacity(0.5)
                      : Colors.white12,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRunning
                          ? Colors.greenAccent
                          : Colors.grey,
                      boxShadow: isRunning
                          ? [
                              BoxShadow(
                                color: Colors.greenAccent.withOpacity(0.5),
                                blurRadius: 10,
                              )
                            ]
                          : [],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isRunning
                          ? 'AI Cruise يعمل الآن'
                          : 'AI Cruise متوقف',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.wifi,
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'الشبكة',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),
            // أزرار التشغيل والإيقاف
            Row(
              children: [
                Expanded(
                  child: _mainButton(
                    title: 'تشغيل',
                    icon: Icons.play_arrow_rounded,
                    buttonColor: Colors.cyanAccent,
                    textColor: Colors.black,
                    onTap: startCruise,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _mainButton(
                    title: 'إيقاف فوري',
                    icon: Icons.stop_rounded,
                    buttonColor: Colors.redAccent,
                    textColor: Colors.white,
                    onTap: stopCruise,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // عنوان الأدوات
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'أدوات AI Cruise',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            // الأدوات
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                _toolCard(
                  icon: Icons.language_rounded,
                  title: 'المواقع',
                  subtitle: 'التعامل مع المواقع',
                ),
                _toolCard(
                  icon: Icons.phone_android_rounded,
                  title: 'الهاتف',
                  subtitle: 'مساعدة في وظائف الهاتف',
                ),
                _toolCard(
                  icon: Icons.smart_toy_rounded,
                  title: 'المساعد الذكي',
                  subtitle: 'تنفيذ الأوامر والمهام',
                ),
                _toolCard(
                  icon: Icons.video_library_rounded,
                  title: 'الفيديو',
                  subtitle: 'مساعدة في صناعة الفيديو',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // مربع الأوامر
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10101C),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.purpleAccent.withOpacity(0.35),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.cyanAccent,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'اكتب أمرك',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'مثال: افتح الموقع...',
                      hintStyle: const TextStyle(
                        color: Colors.white38,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF080811),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.cyanAccent,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // تنبيه الأمان
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF15121F),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.amberAccent.withOpacity(0.3),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'الأمان أولاً: أي تحويل مالي يحتاج إلى تأكيدك الصريح قبل التنفيذ.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // الشريط السفلي
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D18),
          border: Border(
            top: BorderSide(
              color: Colors.white12,
              width: 0.5,
            ),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              icon: Icons.home_rounded,
              title: 'الرئيسية',
              selected: true,
            ),
            _BottomItem(
              icon: Icons.smart_toy_outlined,
              title: 'المساعد',
              selected: false,
            ),
            _BottomItem(
              icon: Icons.build_outlined,
              title: 'الأدوات',
              selected: false,
            ),
            _BottomItem(
              icon: Icons.person_outline,
              title: 'حسابي',
              selected: false,
            ),
          ],
        ),
      ),
    );
  Widget _mainButton({
    required String title,
    required IconData icon,
    required Color buttonColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        elevation: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  Widget _toolCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF11111D),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.purpleAccent.withOpacity(0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.08),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.cyanAccent,
              size: 34,
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  const _BottomItem({
    required this.icon,
    required this.title,
    required this.selected,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: selected ? Colors.cyanAccent : Colors.white38,
          size: 23,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: selected ? Colors.cyanAccent : Colors.white38,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
