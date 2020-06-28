#include "src/ksmcore.as"

#module laser_slam_sound

//
// laser_slam_sound���W���[����������
//
//   p1: ���s�t�@�C��������f�B���N�g���̃p�X(dir_default)
//
#deffunc initLaserSlamSoundModule str p1, local filenamesStr, local filename
	s_dirDefault = p1
	s_maxPolyphony = -1 // �ő哯��������(���ʂ̃o�[�W�������ƂɈقȂ邽�߁A�v���C�J�n����loadLaserSlamSounds�Ŏw�肷��)
	return

//
// �w��o�[�W�����ɂ����钼�p���̍ő哯�����������擾
//
//   p1: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#defcfunc local getMaxPolyphonyForVersion int p1
	if (p1 >= 171) {
		return 1
	} else {
		return 10
	}

//
// ���p���̉����t�@�C�������[�h����
//
//   p1: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#deffunc loadLaserSlamSounds int p1, local pKeySound
	// �O�񃍁[�h���̍ő哯���������ƈقȂ�ꍇ�̓��[�h������
	if (s_maxPolyphony != getMaxPolyphonyForVersion(p1)) {
		s_maxPolyphony = getMaxPolyphonyForVersion(p1)

		// ���p���̉����t�@�C����
		filenamesStr  = "chokkaku.wav\n"
		filenamesStr += "chokkaku_down.wav\n"
		filenamesStr += "chokkaku_up.wav\n"
		filenamesStr += "chokkaku_swing.wav\n"
		filenamesStr += "chokkaku_mute.wav\n"

		// ���p����KeySound�𐶐�
		notesel filenamesStr
		dim s_laserSlamKeySounds, notemax
		repeat notemax
			noteget filename, cnt
			filename = s_dirDefault + "\\se\\" + filename
			
			// KeySound�̎��̂𐶐�
			pKeySound = 0
			if (CreateKeySound@(filename, s_maxPolyphony, varptr(pKeySound))) {
				s_laserSlamKeySounds.cnt = pKeySound
			} else {
				dialog "Error: An error occurred while loading sound \"" + filename + "\""
			}
		loop
	}
	return

//
// ���p�����Đ�����
//
//   p1: ���p���̎�ނ�ID
//   p2: ����(0.0�`1.0)
//
#deffunc playLaserSlamSound int p1, double p2
	// ��ނ�ID���͈͊O�̏ꍇ�͖�������
	if (p1 < 0 || p1 >= length(s_laserSlamKeySounds)) {
		return
	}

	// �Đ�
	if (s_laserSlamKeySounds.p1 != 0) {
		PlayKeySound@ s_laserSlamKeySounds.p1, p2
	}
	return

#global