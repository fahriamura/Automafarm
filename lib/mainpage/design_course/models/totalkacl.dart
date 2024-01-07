double totalKcal(double gramProtein, double beratBadan, double aktivitas) {
  double kaloriProtein = gramProtein * 4;
  double kebutuhanOtot = beratBadan * aktivitas;
  double kaloriDiterima = kaloriProtein - kebutuhanOtot;
  return kaloriDiterima;
}
