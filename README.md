# usenixbadges-overlay
Applies the USENIX badges on top of an existing (Artifact Appendix) PDF.

# Artifact Evaluation hotcrp workflow
1. Add submission information to `input/<instance>-data.csv`. To generate the required information from hotcrp: `Download -> Paper information -> CSV`.
2. Add final PDF versions to `input/<instance-finalxxx.pdf>` files. To generate the required information from hotcrp: `Download -> Documents -> Final versions`
3. Install required packages: `pdftk`
4. Run ./overlay.sh <instance>
5. Grab PDF files with badges in `output/instance-finalxxx-badges.pdf`.
