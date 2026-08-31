#!/bin/bash


set -e

echo "Variant Calling Pipeline Starting..."

echo "Needed tools is installing..."


REQUIRED_PKGS="bwa samtools bcftools default-jre wget unzip"

for pkg in $REQUIRED_PKGS; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo " - $pkg: installed"
    else
        echo " - $pkg: not found. downloading..."
        sudo apt-get update
        sudo apt-get install -y "$pkg"
    fi
done

if [ ! -f "snpEff/snpEff.jar" ]; then
    echo "[*] SnpEff not found. Downloading and installing..."
    wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
    unzip -q snpEff_latest_core.zip
    echo "[*] GRCh38.86 referance human genome is dowloading...."
    java -jar snpEff/snpEff.jar download GRCh38.86
else
    echo " - SnpEff: installed"
fi

echo "All needed tools and files are downloaded and installed"
echo "--------------------------------------------------------"

REF="Homo_sapiens.GRCh38.dna.primary_assembly.fa"
R1="F350066296_L01_14_1.fq.gz"
R2="F350066296_L01_14_2.fq.gz"

echo "1. Reference Genome is being indexed..."
bwa index $REF

echo "2. FASTQ files are aliging and SAM file is being generating..."
bwa mem $REF $R1 $R2 > F350066296_alligment_SAM.sam

echo "3. SAM file is converting to BAM file..."
samtools view -S -b F350066296_alligment_SAM.sam > F350066296_alligment_BAM.bam

echo "4. BAM file is sorting..."
samtools sort F350066296_alligment_BAM.bam -o F350066296_sorted_BAM.bam

echo "5. Sorted BAM file is bView(F350066296$fix)eing indexed..."
samtools index F350066296_sorted_BAM.bam

echo "6. Variant Calling is being proceding..."
bcftools mpileup -O b -f $REF F350066296_sorted_BAM.bam | bcftools call -vmO v -o F350066296_variants.vcf

echo "7. VCF file is being annotated. (With SnpEff)... For this step we needed to install java!"
java -jar snpEff/snpEff.jar GRCh38.86 F350066296_variants.vcf > F350066296_anotated_variants.vcf

echo "Pipeline is completed! From this point we switch to the R environment."
