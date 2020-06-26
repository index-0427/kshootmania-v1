#include "third_party/alib_hash.as"
#include "src/ksmcore.as"

#module key_sound

#define ctype s_keySoundLibrary(%1) HashElem(s_keySoundLibrary, %1)

//
// key_sound���W���[����������
//
//   p1: ���s�t�@�C��������f�B���N�g���̃p�X(dir_default)
//
#deffunc initKeySoundModule str p1
	s_dirDefault = p1

	// �L�[�����i�[���Ă������C�u����
	// (�L�[���̖��O��KeySound�ւ̃|�C���^��Ή��t���鎫��: dict<str, KeySound*>)
	HashInitInt s_keySoundLibrary
	HashClear s_keySoundLibrary
	return

//
// �m�[�gSE�̖��O���特���t�@�C���̃p�X���擾
// (�g���q���Ȃ��ꍇ�ɂ�"se\note"�f�B���N�g�����̃t�@�C�����g�p)
//
//   p1: �m�[�gSE�̖��O(��:"clap")
//
#defcfunc getFilePathByKeySoundName str p1, local name
	if(getpath(p1, 2) = ""){
		return s_dirDefault + "\\se\\note\\" + p1 + ".wav"
	} else {
		return p1
	}

//
// �w��o�[�W�����ɂ�����m�[�gSE�̍ő哯�����������擾
//
//   p1: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#defcfunc getKeySoundMaxForVersion int p1
	if (p1 >= 171) {
		return 1
	} else {
		return 0
	}

//
// �m�[�gSE�����C�u�����ɓǂݍ���
// (�����m�[�gSE�����ɓǂݍ��܂�Ă���ꍇ�͉������Ȃ�)
//
//   p1: �m�[�gSE�̖��O(��:"clap")
//   p2: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#deffunc loadKeySoundToLibrary str p1, int p2, local soundFilePath, local pKeySound
	// �܂��ǂݍ��񂾂��Ƃ��Ȃ����ʉ��̏ꍇ�͓ǂݍ���
	if (HashCheckKey(s_keySoundLibrary, p1) = 0) {
		// �����t�@�C���̃p�X���擾���đ��݃`�F�b�N
		soundFilePath = getFilePathByKeySoundName(p1)
		exist soundFilePath
		if(strsize <= 0){
			dialog "Error: Cannot open sound \"" + soundFilePath + "\""
		}

		// KeySound�̎��̂𐶐�
		pKeySound = 0
		if (CreateKeySound(soundFilePath, getKeySoundMaxForVersion(p2)/*�m�[�gSE�̓����Đ���*/, varptr(pKeySound))) {
			s_keySoundLibrary(p1) = pKeySound
		} else {
			dialog "Error: An error occurred while loading sound \"" + p1 + "\""
			s_keySoundLibrary(p1) = 0
		}
	}
	return

//
// �m�[�gSE�̖��O�����ƂɃ��C�u��������KeySound�ւ̃|�C���^���擾
//
//   p1: �m�[�gSE�̖��O(��:"clap")
//   p2: ksh���ʂ�"ver"�t�B�[���h�̐�������(int�^)
//
#defcfunc getKeySoundFromLibrary str p1
	if (HashCheckKey(s_keySoundLibrary, p1) = 0) {
		// ���C�u�����ɑ��݂��Ȃ��ꍇ��NULL��Ԃ�
		dialog "Error: Unknown keysound \"" + p1 + "\" is referenced by getKeySoundFromLibrary@key_sound"
		return 0
	}
	return s_keySoundLibrary(p1)

//
// ���C�u�����̃L�[�����N���A
//
#deffunc clearKeySoundLibrary
	foreach s_keySoundLibrary_keys
  		if (s_keySoundLibrary_keys(cnt) = "") : continue
  		if (s_keySoundLibrary_values.cnt = 0) : continue
		DestroyKeySound@ s_keySoundLibrary_values.cnt
	loop
	HashClear s_keySoundLibrary
	return

#global