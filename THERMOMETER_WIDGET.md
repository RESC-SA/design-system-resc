# 🌡️ مقياس الحرارة والرطوبة ثلاثي الأبعاد الواقعي | 3D Photorealistic Thermometer & Hygrometer

عنصر واجهة مستخدم (Widget) فائق الدقة والواقعية في فلاتر (Flutter) يحاكي مقياس الحرارة الزجاجي الكلاسيكي بدقة فيزيائية 100%، مع دعم مقياس الرطوبة، وبكرة القراءة الأسطوانية، ونظام الإنذار عند درجات الحرارة الحرجة مع الهزاز وصوت التنبيه، والتخصيص الكامل للألوان والنصوص بدون أي قيود أو حاويات ثابتة.

---

## 📑 الفهرس (Table of Contents)

1. [الميزات الرئيسية (Key Features)](#-الميزات-الرئيسية-key-features)
2. [معاينة المعاملات والخصائص (API Properties Reference)](#-معاينة-المعاملات-والخصائص-api-properties-reference)
3. [الألوان والتخصيص الكامل (`ThermometerColors`)](#-الألوان-والتخصيص-الكامل-thermometercolors)
4. [النطاقات الحرارية وحالات الرطوبة (Thresholds & States)](#-النطاقات-الحرارية-وحالات-الرطوبة-thresholds--states)
5. [نظام الإنذار الحرج مع الهزاز والصوت (Danger Alert System)](#-نظام-الإنذار-الحرج-مع-الهزاز-والصوت-danger-alert-system)
6. [أنماط قراءة البكرة الدائرية (`ThermometerReadoutStyle`)](#-أنماط-قراءة-البكرة-الدائرية-thermometerreadoutstyle)
7. [أمثلة برمجية شاملة (Comprehensive Code Examples)](#-أمثلة-برمجية-شاملة-comprehensive-code-examples)
   - [1. الاستخدام الأساسي السريع](#1-الاستخدام-الأساسي-السريع-basic-usage)
   - [2. الاستخدام المتقدم مع إنذار الخطر والرطوبة](#2-الاستخدام-المتقدم-مع-إنذار-الخطر-والرطوبة-advanced-iot--alert)
   - [3. تخصيص كامل للألوان والنصوص باللغة العربية](#3-تخصيص-كامل-للألوان-والنصوص-باللغة-العربية-custom-colors--arabic-labels)
   - [4. مقياس الرطوبة المستقل (`HygrometerWidget`)](#4-مقياس-الرطوبة-المستقل-hygrometerwidget)

---

## 🌟 الميزات الرئيسية (Key Features)

* **زجاج وسوائل فيزيائية ثلاثية الأبعاد (Photorealistic 3D Glass & Fluid)**:
  - محاكاة انعكاسات الضوء العلوية والجانبية (Specular Streaks & Crescent Glint).
  - تدرج لوني أسطواني يمنح السائل عمقاً حجمياً (Volumetric Depth).
  - محاكاة دقيقة للسطح الهلالي للسائل (Liquid Meniscus).
  - مستودع كروي ثلاثي الأبعاد مع توهج داخلي وانعكاس سطحي مقوس.

* **عنصر نقي وشفاف بدون أي حاوية إجبارية (Zero-Container Overhead)**:
  - لا يفرض المقياس أي بطاقة خلفية أو ألوان ثابتة، مما يجعله شفافاً تماماً ليوضع فوق أي خلفية أو تصميم بحرية.

* **ودجيت علوية وسفلية خارج التصميم بمسافات قابلة للضبط (`topWidgetSpacing` & `humiditySpacing`)**:
  - إمكانية وضع أيقونة أو أنيميشن في الأعلى (مكان الشمس أو SVG أو Lottie متحرك) خارج زجاج المقياس مع التحكم بمسافته بالبكسل.
  - إمكانية وضع ودجيت الرطوبة أسفل المستودع الكروي خارج المقياس بمسافة محددة بالبكسل.

* **بكرة قراءة أسطوانية ثلاثية الأبعاد (3D Rolling Wheel Readout)**:
  - عرض القيمة الحالية عبر بكرة أسطوانية تحتوي على 3 شرطات: الشرطة العلوية والسفلية شبه مختفية (تلاشي بنسبة 60%) والوسطى بارزة ومضيئة بنسبة 100% مع القيمة الحية.
  - إمكانية دمج البكرة مباشرة على مسار التدريج الأيمن مكان الـ C أو جعلها عائمة.

* **تخصيص كامل للألوان والنصوص بنسبة 100% (Zero Hardcoded Values)**:
  - تخصيص ألوان كل جزء عبر كلاس `ThermometerColors`.
  - تخصيص تسميات الوحدات (`celsiusUnitLabel`, `fahrenheitUnitLabel`, `humidityUnitLabel`).
  - تخصيص مسميات حالات الجو (`dryLabel`, `comfortableLabel`, `humidLabel`).

* **نظام إنذار عند بلوغ درجات الحرارة الحرجة (Critical Danger Alert)**:
  - تفعيل هزاز الهاتف التلقائي الإجباري (`HapticFeedback.heavyImpact()` و `HapticFeedback.vibrate()`).
  - تشغيل صوت تنبيه النظام (`SystemSound.play()`) أو مشغل صوت مخصص لملفات الصوت (`customAlertSoundPlayer`).
  - هالة ضوئية متوهجة ونابضة حول مقياس الحرارة تحذيراً بارتفاع أو انخفاض الحرارة بشكل خطر.
  - نبض أحمر متوهج على البصيلة نفسها (كرة الزئبق السفلية): إضاءة داخلية + حافة متوهجة + موجة توسّع، محكومة بـ `showAlertVisualPulse`.

* **دعم معادلات وصيغ درجات الحرارة المخصصة (`valueFormatter`)**:
  - إمكانية كتابة أي معادلة لعرض الحرارة بوحدات الكلفن (Kelvin) أو فهرنهايت أو إضافة نصوص مخصصة.

* **مقياس رطوبة مدمج ومستقل (`HygrometerWidget`)**:
  - قياس نسبة الرطوبة النسبية (% RH) بقوس سائل دائري متوهج وبادج تقييم حالة الجو (جاف / مثالي / رطب).

---

## 📊 معاينة المعاملات والخصائص (API Properties Reference)

### معاملات `ThermometerWidget`

| المعامل (Property) | النوع (Type) | القيمة الافتراضية | الوصف (Description) |
| :--- | :--- | :--- | :--- |
| `celsius` | `double?` | `32.0` | درجة الحرارة الحالية بوحدة السيلزيوس (°C). |
| `fahrenheit` | `double?` | `null` | درجة الحرارة بوحدة الفهرنهايت (تُحوّل تلقائياً لسيلزيوس إن وُجدت). |
| `minCelsius` | `double` | `-30.0` | الحد الأدنى لمقياس السيلزيوس. |
| `maxCelsius` | `double` | `50.0` | الحد الأقصى لمقياس السيلزيوس. |
| `minFahrenheit` | `double` | `-20.0` | الحد الأدنى لمقياس الفهرنهايت. |
| `maxFahrenheit` | `double` | `125.0` | الحد الأقصى لمقياس الفهرنهايت. |
| `showCelsius` | `bool` | `true` | إظهار أو إخفاء تدريج السيلزيوس على اليمين. |
| `showFahrenheit` | `bool` | `true` | إظهار أو إخفاء تدريج الفهرنهايت على اليسار. |
| `showMinorLabels` | `bool` | `true` | إظهار أرقام التدريج الدقيق (Micro-Labels) عند كل شرطة فرعية. |
| `width` | `double?` | `null` | العرض المخصص (يتكيف تلقائياً مع الحاوية إن لم يُحدد). |
| `height` | `double?` | `null` | الارتفاع المخصص (يتكيف تلقائياً مع الحاوية إن لم يُحدد). |
| `topWidgetSpacing` | `double` | `12.0` | المسافة بالبكسل بين أعلى زجاج المقياس والودجيت العلوية. |
| `humiditySpacing` | `double` | `14.0` | المسافة بالبكسل بين أسفل مستودع الزجاج الكروي وودجيت الرطوبة. |
| `humidity` | `double?` | `null` | نسبة الرطوبة الحالية من 0 إلى 100 (% RH). |
| `showHumidity` | `bool?` | `null` | إظهار أو إخفاء مقياس الرطوبة تماماً. |
| `humidityPosition` | `ThermometerHumidityPosition` | `bottomPill` | موضع وشكل ودجيت الرطوبة (`bottomPill`, `sideDial`, `none`). |
| `criticalMaxCelsius` | `double?` | `null` | درجة الحرارة القصوى التي يبدأ عندها إطلاق إنذار الخطر. |
| `criticalMinCelsius` | `double?` | `null` | درجة الحرارة الدنيا التي يبدأ عندها إطلاق إنذار الصقيع/الخطر. |
| `enableAlertVibration` | `bool` | `true` | تفعيل اهتزاز الهاتف عند تجاوز حد الخطر. |
| `enableAlertSound` | `bool` | `true` | تفعيل صوت تنبيه الهاتف عند تجاوز حد الخطر. |
| `showAlertVisualPulse` | `bool` | `true` | تفعيل الهالة الضوئية النابضة عند الخطر. |
| `onAlertTriggered` | `Function(double, bool)?` | `null` | رد نداء يُستدعى عند تفعيل الإنذار `(celsius, isMaxCritical)`. |
| `customAlertSoundPlayer`| `VoidCallback?` | `null` | دالة لتشغيل ملف صوت مخصص من المشروع عند الإنذار. |
| `colors` | `ThermometerColors?` | `null` | لوحة ألوان مخصصة بالكامل لجميع أجزاء المقياس. |
| `celsiusUnitLabel` | `String` | `'°C'` | نص تسمية وحدة السيلزيوس. |
| `fahrenheitUnitLabel`| `String` | `'°F'` | نص تسمية وحدة الفهرنهايت. |
| `humidityUnitLabel` | `String` | `'%'` | نص تسمية وحدة الرطوبة. |
| `dryLabel` | `String?` | `null` | النص المخصص لحالة الجو الجاف (افتراضي: 'جاف'). |
| `comfortableLabel` | `String?` | `null` | النص المخصص لحالة الجو المعتدل (افتراضي: 'مثالي'). |
| `humidLabel` | `String?` | `null` | النص المخصص لحالة الجو الرطب (افتراضي: 'رطب'). |
| `fluidTheme` | `ThermometerFluidTheme` | `redSpirit` | المظهر اللوني للسائل (`redSpirit`, `mercury`, `ecoGreen`, `oceanBlue`, `amberGold`, `deepPurple`). |
| `autoTheme` | `bool` | `false` | تفعيل التغيير التلقائي لألوان السائل والتوهج ديناميكياً مع حركة وتغير الحرارة (أزرق للبارد، أخضر للمعتدل، كهرماني للدافئ، أحمر للحار). |
| `fluidThemeBuilder` | `Function(double, State)?` | `null` | دالة بناء ديناميكية مخصصة لتحديد مظهر السائل حسب درجة الحرارة الحالية `(celsius, state)`. |
| `colorsBuilder` | `Function(double, State)?` | `null` | دالة بناء ديناميكية مخصصة لتوليد ألوان `ThermometerColors` بالكامل حسب القيمة الحالية `(celsius, state)`. |
| `readoutStyle` | `ThermometerReadoutStyle` | `circularWheel` | نمط عرض القيمة الحالية (`circularWheel`, `integratedScaleWheel`, `simpleBadge`, `none`). |
| `topWidget` | `Widget?` | `null` | ودجيت مخصصة ثابتة للأعلى (مثل أيقونة أو SVG أو Lottie). |
| `topWidgetBuilder` | `Widget Function(...)` | `null` | دالة بناء ديناميكية لتغيير عنصر الأعلى وفقاً لحالة الحرارة. |
| `valueFormatter` | `String Function(double)?`| `null` | معادلة أو صيغة مخصصة لتنسيق وعرض نص الحرارة. |
| `interactive` | `bool` | `true` | إمكانية السحب واللمس المباشر لتغيير القيمة. |
| `onChanged` | `ValueChanged<double>?` | `null` | رد نداء يُستدعى عند تغيير القيمة بالسحب أو اللمس. |

---

## 🎨 الألوان والتخصيص الكامل (`ThermometerColors`)

يوفر كلاس `ThermometerColors` تحكماً مطلقاً في كل بكسل لوني داخل المقياس:

```dart
const ThermometerColors({
  Color? fluidPrimary,      // لون السائل الأساسي
  Color? fluidDeep,         // لون حواف السائل المظلمة للعمق
  Color? fluidHighlight,    // لون خط الإضاءة اللامع وسط السائل
  Color? fluidGlow,         // لون توهج السائل المحيط بالمستودع
  Color? majorTick,         // لون التدريجات الرئيسية (5, 10, 15...)
  Color? mediumTick,        // لون التدريجات المتوسطة
  Color? minorTick,         // لون التدريجات الفرعية الصغيرة
  Color? majorText,         // لون أرقام التدريجات الرئيسية
  Color? mediumText,        // لون أرقام التدريجات المتوسطة
  Color? minorText,         // لون أرقام التدريج المصغر
  Color? unitHeader,        // لون شارات وحدات القياس (°C / °F)
  Color? glassBezel,        // لون إطار الزجاج الخارجي
  Color? glassBore,         // لون أنبوب الفراغ الداخلي
  Color? glassHighlight,    // لون اللمعات والانعكاسات الزجاجية
  Color? readoutBackground, // خلفية بادج القراءة
  Color? readoutText,       // نص قراءة الحرارة
  Color? humidityBackground,// خلفية كبسولة الرطوبة
  Color? humidityBorder,    // إطار كبسولة الرطوبة
  Color? humidityText,      // نص نسبة الرطوبة
  Color? humidityIcon,      // أيقونة قطرة الرطوبة
  Color? alertGlow,         // لون الهالة النابضة عند الخطر
})
```

---

## 🌡️ النطاقات الحرارية وحالات الرطوبة (Thresholds & States)

### 1. تصنيف درجات الحرارة (`ThermometerThresholds`)
تُصنّف درجات الحرارة تلقائياً إلى 4 حالات ديناميكية:
- ❄️ **Cool (بارد)**: أقل من `coolThreshold` (افتراضي: أقل من 18°C).
- 🌿 **Normal (معتدل)**: بين `coolThreshold` و `normalThreshold` (افتراضي: 18°C - 28°C).
- ☀️ **Warm (دافئ)**: بين `normalThreshold` و `warmThreshold` (افتراضي: 28°C - 38°C).
- 🔥 **Hot (حار)**: أعلى من `warmThreshold` (افتراضي: أعلى من 38°C).

### 2. تصنيف حالات الرطوبة (`ThermometerHumidityThresholds`)
- 🏜️ **Dry (جاف)**: أقل من `dryThreshold` (افتراضي: أقل من 30%).
- 💧 **Comfortable (مثالي)**: بين 30% و 60%.
- 🌧️ **Humid (رطب)**: أعلى من `humidThreshold` (افتراضي: أعلى من 60%).

---

## 🚨 نظام الإنذار الحرج مع الهزاز والصوت (Danger Alert System)

عند وصول درجة الحرارة للحد الأقصى (`criticalMaxCelsius`) أو الحد الأدنى (`criticalMinCelsius`):
1. **الهزاز الفيزيائي**: يُطلق الهاتف اهتزازاً ملموساً وقوياً عبر `HapticFeedback.heavyImpact()` و `HapticFeedback.vibrate()`.
2. **صوت التنبيه**: يصدر صوت النظام `SystemSoundType.alert` أو يتم استدعاء دالتك المخصصة `customAlertSoundPlayer` لتشغيل ملف صوتي من التطبيق.
3. **نبض بصري متوهج**: تنبض هالة متوهجة باللون الأحمر (أو اللون المخصص في `colors.alertGlow`) حول زجاج المقياس.
4. **حماية الأداء (Throttling)**: لن يتكرر الصوت والهزاز أكثر من مرة واحدة كل 700 مللي ثانية لمنع الإزعاج في تدفق قراءات الحساسات السريعة.

---

## 🛞 أنماط قراءة البكرة الدائرية (`ThermometerReadoutStyle`)

1. `ThermometerReadoutStyle.circularWheel`:
   - بكرة أسطوانية ثلاثية الأبعاد عائمة على يمين المقياس مع 3 شرطات (الشرطة العلوية والسفلية بتلاشي 60% والوسطى واضحة 100%).
2. `ThermometerReadoutStyle.integratedScaleWheel`:
   - تثبيت البكرة الأسطوانية مباشرة على مسار تدريج السيلزيوس الأيمن بدلاً من أن تكون عائمة.
3. `ThermometerReadoutStyle.simpleBadge`:
   - بادج مستطيل بزوايا منحنية يعرض القيمة برقة وأناقة.
4. `ThermometerReadoutStyle.none`:
   - إخفاء بادج القراءة والاعتماد على تدريج الأرقام فقط.

---

## 💻 أمثلة برمجية شاملة (Comprehensive Code Examples)

### 1. الاستخدام الأساسي السريع (Basic Usage)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class SimpleThermometerDemo extends StatelessWidget {
  const SimpleThermometerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ThermometerWidget(
        celsius: 26.5,
        interactive: true,
        onChanged: (newCelsius) {
          print('Current temperature: $newCelsius °C');
        },
      ),
    );
  }
}
```

---

### 2. الاستخدام المتقدم مع إنذار الخطر والرطوبة (Advanced IoT & Alert)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class IoTTelemetryScreen extends StatefulWidget {
  const IoTTelemetryScreen({super.key});

  @override
  State<IoTTelemetryScreen> createState() => _IoTTelemetryScreenState();
}

class _IoTTelemetryScreenState extends State<IoTTelemetryScreen> {
  double _temperature = 41.5; // درجة حرارة تتجاوز حد الخطر
  double _humidity = 72.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: ThermometerWidget(
          celsius: _temperature,
          humidity: _humidity,
          showHumidity: true,
          humidityPosition: ThermometerHumidityPosition.bottomPill,
          topWidgetSpacing: 14.0,
          humiditySpacing: 16.0,
          
          // إعدادات الإنذار الحرج (عند تجاوز 39°C)
          criticalMaxCelsius: 39.0,
          enableAlertVibration: true,
          enableAlertSound: true,
          onAlertTriggered: (celsius, isMax) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('⚠️ تنبيه: تم رصد حرارة خطرة بقيمة ${celsius.toStringAsFixed(1)}°C!'),
                backgroundColor: Colors.redAccent,
              ),
            );
          },
          
          // ودجيت الأعلى التفاعلية مع درجات الحرارة
          topWidgetBuilder: (context, celsius, state) {
            final (icon, color, text) = switch (state) {
              ThermometerTemperatureState.cool => (Icons.ac_unit, Colors.cyan, 'بارد'),
              ThermometerTemperatureState.normal => (Icons.eco, Colors.green, 'معتدل'),
              ThermometerTemperatureState.warm => (Icons.wb_sunny, Colors.orange, 'دافئ'),
              ThermometerTemperatureState.hot => (Icons.local_fire_department, Colors.red, 'حار جداً'),
            };

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: 4),
                  Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
                ],
              ),
            );
          },
          onChanged: (val) => setState(() => _temperature = val),
        ),
      ),
    );
  }
}
```

---

### 3. تخصيص كامل للألوان والنصوص باللغة العربية (Custom Colors & Arabic Labels)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class ArabicCustomThermometer extends StatelessWidget {
  const ArabicCustomThermometer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ThermometerWidget(
        celsius: 24.0,
        humidity: 45.0,
        showHumidity: true,
        showFahrenheit: false, // إخفاء مقياس الفهرنهايت والتركيز على السيلزيوس
        
        // تسميات الوحدات والنصوص المعربة بالكامل
        celsiusUnitLabel: 'م°',
        humidityUnitLabel: '٪',
        dryLabel: 'طقس جاف',
        comfortableLabel: 'طقس معتدل ومريح',
        humidLabel: 'طقس رطب',
        
        // معادلة تنسيق نص الحرارة المخصصة
        valueFormatter: (c) => '${c.toStringAsFixed(1)} درجة مئوية',
        
        // تخصيص ألوان بنفسجية ملكية فخمة
        colors: const ThermometerColors(
          fluidPrimary: Color(0xFF8B5CF6),
          fluidDeep: Color(0xFF5B21B6),
          fluidHighlight: Color(0xFFDDD6FE),
          fluidGlow: Color(0x668B5CF6),
          majorTick: Color(0xFF8B5CF6),
          majorText: Color(0xFF8B5CF6),
          unitHeader: Color(0xFF8B5CF6),
          humidityBorder: Color(0xFF8B5CF6),
          humidityText: Color(0xFFDDD6FE),
        ),
      ),
    );
  }
}
```

---

### 4. مقياس الرطوبة المستقل (`HygrometerWidget`)

يمكن استخدام مقياس الرطوبة الدائري ثلاثي الأبعاد بشكل منفصل في أي بطاقة أو لوحة تحكم:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class StandaloneHygrometerDemo extends StatelessWidget {
  const StandaloneHygrometerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // رطوبة منخفضة (جاف)
        HygrometerWidget(
          humidity: 22,
          size: 90,
          dryLabel: 'جاف',
        ),
        
        // رطوبة مثالية (معتدل)
        HygrometerWidget(
          humidity: 55,
          size: 90,
          comfortableLabel: 'مثالي',
        ),
        
        // رطوبة مرتفعة (رطب)
        HygrometerWidget(
          humidity: 85,
          size: 90,
          humidLabel: 'رطب',
        ),
      ],
    );
  }
}
```

---

## 🧪 الاختبارات والجودة (Testing & Code Quality)

تم تغطية جميع مكونات المقياس بحزمة اختبارات برمجية شاملة (`Unit & Widget Tests`):
```bash
flutter test test/thermometer_test.dart
```
- ✅ اختبار عرض التدريجين (Celsius & Fahrenheit) وضبط الأبعاد الديناميكي.
- ✅ اختبار التفاعل بالسحب واللمس المباشر.
- ✅ اختبار أنماط البكرة الدائرية (`ThermometerReadoutStyle`).
- ✅ اختبار استدعاء ودجيت الأعلى ومعادلات الحساب `valueFormatter`.
- ✅ اختبار تصنيف النطاقات الحرارية والرطوبة (`Thresholds`).
- ✅ اختبار تفعيل هزاز وصوت وإنذار الخطر `criticalMaxCelsius`.
- ✅ اختبار التخصيص الكامل للألوان والتسميات النصية.

---

**تصميم وبرمجة بأعلى معايير الأداء والفيزياء البصرية في فلاتر (Flutter Design System).**
