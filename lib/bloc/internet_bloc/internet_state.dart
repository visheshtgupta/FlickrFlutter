part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetGainedState extends InternetState {}

class InternetLossState extends InternetState {}
