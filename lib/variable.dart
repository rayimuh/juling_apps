// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import "package:flutter/material.dart";
import "package:intl/intl.dart";

//Add Data
TextEditingController dateController = TextEditingController();
TextEditingController foundController = TextEditingController();
String number="";
TextEditingController dueDateController = TextEditingController();
TextEditingController SPKController = TextEditingController();
TextEditingController locationController = TextEditingController();
String? selectedProgress;
String? selectedStatus;
String? selectedInfo;
String? selectedCategory;
String? selectedSubcategory;
String? selectedPic;
String imageBefore = '';
String imageAfter = '';
var progressList = [
  "Open",
  "Material Preparation",
  "Progress Construction",
  "Completed" 
];
var filterCompleteOrNot = [  
  "Completed",
  "Non-Completed"
];
Map<String, List<String>> category = {
  "General Services": ["Kebersihan", "Taman/Landscape"],
  "Maintenance": ["Sipil", "Mekanikal", "Elektrikal"],
  "Others": ["Others"],
};
var pic=["Advanced Support","MBUT","Others"];
var statusList = ["Need Update", "No Need Update"];
var informationList = ["SPK", "Non SPK"];

//Edit Data
String editNumber="";
TextEditingController editDateController = TextEditingController();
TextEditingController editFoundController = TextEditingController();
TextEditingController editDueDateController = TextEditingController();
TextEditingController editSPKController = TextEditingController();
TextEditingController editLocationController = TextEditingController();
String? editSelectedProgress;
String? editSelectedStatus;
String? editSelectedInfo;
String? editImageBefore;
String? editImageAfter;
String? editPic;
String? editCategory;
String? editSubCategory;

//Chart
TextEditingController chartDateBegin = TextEditingController();
TextEditingController chartDateEnd = TextEditingController();
var filterStart,
    filterEnd,
    chartStart,
    chartEnd,
    pickedDateToFilterStart,
    pickedDateToFilterEnd,
    pickedDateToChartStart,
    pickedDateToChartEnd;

//Filter
TextEditingController filterDateBegin = TextEditingController();
TextEditingController filterDateEnd = TextEditingController();
TextEditingController filterSPK = TextEditingController();
TextEditingController filterNumber=TextEditingController();
String? filterProgress;
String? completedOrNot;
String? filterStatus;
String? filterCategory;
String? filterPIC;

//Auth Maintenance
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

var dateNow = DateTime.now();
final DateFormat formatMonth = DateFormat('MMMM');

//Maintenance Photo
String maintenanceBefore='';
String maintenanceNew='';

//List Data
bool isReversed = false;

//Count Data
num materialPrep = 0,
    grandTotal = 0,
    completed = 0,
    open = 0,
    progressCons = 0,
    needUpdate = 0,
    noNeedUpdate = 0,
    totalData = 0;


