import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class Step1 extends StatefulWidget {
  final Function(String) onMedicineNameChanged;
  final Function(String) onMedicineTypeChanged;
  final Function(int) onAmountChanged;
  final Function(String) onConnectionWithFoodChanged;

  const Step1({
    super.key,
    required this.onMedicineNameChanged,
    required this.onMedicineTypeChanged,
    required this.onAmountChanged,
    required this.onConnectionWithFoodChanged,
  });

  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  String medicineType = '';
  String connectionWithFood = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTopButton(Icons.camera_alt, 'Add Photo'),
              _buildTopButton(Icons.document_scanner, 'Scan'),
              _buildTopButton(Icons.mic, 'Audio Vocal'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Medicine Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Mildronate 500 mg',
              border: OutlineInputBorder(),
            ),
            onChanged: widget.onMedicineNameChanged,
          ),
          const SizedBox(height: 16),
          const Text(
            'Medicine Type',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildMedicineTypeItem('Tablet', 'assets/img/tablet.png'),
                _buildMedicineTypeItem('Capsule', 'assets/img/capsule.png'),
                _buildMedicineTypeItem('Injection', 'assets/img/injection.png'),
                _buildMedicineTypeItem('Drop', 'assets/img/drop.png'),
                _buildMedicineTypeItem('Band', 'assets/img/band.png'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Amount',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              hintText: '30',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onAmountChanged(int.tryParse(value) ?? 0);
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Connection with food',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _buildConnectionWithFoodButton('In time'),
              _buildConnectionWithFoodButton('Before eat'),
              _buildConnectionWithFoodButton('After eat'),
              _buildConnectionWithFoodButton('No matter'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        color: AppColors.primaryBlue,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: AppColors.primaryBlue,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ThirdBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  Widget _buildMedicineTypeItem(String title, String imagePath) {
    bool isSelected = medicineType == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          medicineType = title;
        });
        widget.onMedicineTypeChanged(title);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : Colors.transparent,
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(imagePath, height: 50, width: 50),
                ),
                if (isSelected)
                  Positioned(
                    bottom: -3,
                    right: -3,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.primaryBlue,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.primaryBlue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionWithFoodButton(String label) {
    bool isSelected = connectionWithFood == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            connectionWithFood = isSelected ? '' : label;
          });
          widget.onConnectionWithFoodChanged(connectionWithFood);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.black : AppColors.whiteBg,
          foregroundColor: isSelected ? AppColors.white : AppColors.greyClr,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}