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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A12),
        primaryColor: Colors.purpleAccent,
      ),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // أيقونة الروبوت مع التأثير المضيء
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.cyanAccent, Colors.purpleAccent],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF12121F),
                child: Icon(Icons.smart_toy, size: 50, color: Colors.cyanAccent),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'AI Cruise',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'مرحباً بك في AI Cruise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'كل ما تحتاجه من أدوات الذكاء الاصطناعي في مكان واحد',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),        
            // شبكة الأزرار الأربعة الرئيسية
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildFeatureCard(
                  title: 'تشغيل سريع',
                  subtitle: 'بدء الواتساب والمهام',
                  icon: Icons.play_arrow_rounded,
                  color: Colors.purple.shade900.withOpacity(0.6),
                  borderColor: Colors.purpleAccent,
                  onTap: () {},
                ),
                _buildFeatureCard(
                  title: 'إيقاف فوري',
                  subtitle: 'إيقاف العمليات حالاً',
                  icon: Icons.stop_rounded,
                  color: Colors.deepPurple.shade900.withOpacity(0.6),
                  borderColor: Colors.deepPurpleAccent,
                  onTap: () {},
                ),
                _buildFeatureCard(
                  title: 'الدردشة الذكية',
                  subtitle: 'اسأل، وتواصل في أي وقت',
                  icon: Icons.chat_bubble_outline_rounded,
                  color: Colors.indigo.shade900.withOpacity(0.5),
                  borderColor: Colors.blueAccent,
                  onTap: () {},
                ),
                _buildFeatureCard(
                  title: 'توليد الصور',
                  subtitle: 'أرسل وصف، وتخيل معي',
                  icon: Icons.image_outlined,
                  color: Colors.indigo.shade900.withOpacity(0.5),
                  borderColor: Colors.blueAccent,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D15),
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.code, 'المساعد', false),
            _buildBottomNavItem(Icons.mic, 'الصوت', false),
            _buildBottomNavItem(Icons.tune, 'الأدوات', false),
            _buildBottomNavItem(Icons.person_outline, 'الملف الشخصي', false),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBottomNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.cyanAccent : Colors.grey,
          size: 22,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.cyanAccent : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
