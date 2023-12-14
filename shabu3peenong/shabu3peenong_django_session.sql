-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: shabu3peenong
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0gig2tlfdmig72m0atdocp6dk5n2e38h','.eJxVjEEOwiAQRe_C2hAYQKhL9z0DGRhGqoYmpV0Z765NutDtf-_9l4i4rTVuvSxxInERWpx-t4T5UdoO6I7tNss8t3WZktwVedAux5nK83q4fwcVe_3W3gwwoDUILhtHllSgBIGgeO2RAJm15TNhMEqRL5pDUMo5sEyeXRbvD9jyN88:1r9W7E:yyuL8TfDWdvJrAKdvS7ecrwUJ5Tj6mgBY7SKZMqCQm0','2023-12-16 19:57:28.288121'),('bys23iqbm73lp3lueaxdut33foldgwvo','.eJxtj7EOgzAMRP8lM4qIUYAwducbkJOYQktJFcJQIf69SctQpG53vvOTvbEO1zB060K-Gy1rmGDZ70yjudOcAnvD-eq4cXPwo-apwo904a2zNF2O7gkw4DIkrFCV7I1RVqE2FnJJYHPIqa4NFiaX0WMFvQLUqkAtBUkpSqgAdImVitB-nAJ51mx_FHt6Z1cT2L5n7EXo23jmkBon8_iKz5MpiBJkWcat_Q2xl1dB:1rD8Fp:jaolZopnZSZl6MZNkWxkuG7W_WMLrNiyrQocZhAtwXE','2023-12-26 19:17:17.181602'),('g0266ct3lmf1j50dh1vfi3jka9d0g4vl','.eJztfV2P5TiS3V8p9JMNp2d1-CFK_bazC9iAYWCA8b41MMiqynb3bk030NNteDGe_-68pHR5mGSJTCYvU5y9T8kkJR0yGDqMIENx__rNnx5_-_WHP_32l6df_vTj52--_QbfPHDdx8dP__b006Xh878-_vS_f_7dp59_-vWXHz_-7nLJ77bWv_zuf_78-enL77drgwf88PiXHy6PxWr0958-rZ_Xx4-fPotJP4nPk5ieluXTo_w06ef_H434fhWPH1f5-FHjSWvMwgjxcX406_NDPz_--vj9L49_fnp-3F-_--a7736bnoSxfyTsH6zuz1ap7R-1fPfNt8_XT89_vvvm-cJ_eL7qH4T8IPCtfm57uFR-tUl8vUl-vUl9vUl_vWn-epP5etPy9ab1YMhH4jiQBw4EggOJ4EAkOJAJDoSCA6ngQCw4kIs4kIs40pMDuYgDuYgDuYgDuYgDuYgDuYgDuYgDucgDucgDucijF-hALvJALvJALvJALvJALvJALvJALupALupALupALuqIWQ7kog7kog7kog7kog7kog7kog_kog_kog_komO5TN9eJvXSFsvFt8Vy8W2xXHxbLBffFsvFt8VyubbNsVx8WywX3xbLxbcdyGU-kMt8IJf5QC7zgVzmA7nMB3IxB3IxB3IxB3IxB3IxB3IxB3IxB3IxB3IxKbmIrS0ll61tScllb0vJZW9LyWVvS8llb0vJZW9LyWVvS8llb0vJZW87kMtyIJf1QC7rgVzWA7msKblcDJdLW0oue1tKLntbSi57W0oue1tKLntbSi5bG6aUYK6NKclcG1OiuTYeyAbTgXAwHUgH04F4MB3IB9OBgDAdSShh-lLjkYQSxi81HkkoYf5S45GEEgYwNR5JKGECU-ORhBJGMDUeSShhBlPjkYQShjA1HkkoYQpT45GEEsYwNUYSwvrtRT2spxNJ6Lnx8urZxkhC3BhJiBsjCXFjJCFujCTEjZGEuDGSEDdGEuLGlIT2xtgw5sYjCcWmMTceSSg2jrnxSEKxecyNRxKKDWRuPJJQbCJz45GEYiOZG48kFJvJ3HgkodhQxvKt3t6V2FJ-brwsGbYxlhA1xhLyjbGxzI2xhKgxlhA1xhKixlhC1BhLiBpTEro2HkkoNpq5MZaQ-fair5fG2GzmxlhC1BhLyHyLfWMllhA1xhKixlhC1BhLiBpjCVFjLCFqTElob4wNaG5MSejaeCSh2IbmxiMJxVY0Nx5JKLajufFIQrElfWnUrjE2pbkxKaHnxr89bFuwz0Rvd2LdbuuzEZncgrV_pGt7DO5z_wnXptx9U7Bnq_7r81upt5U3qhFRjYxqVFSjo5o5qjFRzRLVrHEPE52Oe42424j7jbjjiHuOuOuI-46484h7L-Lei4TM496LuPci7r3g3ruVRcxxlYmrlrhqjarkFFchrhJxlYyrVFwV917GvZdx72Xcexn3XsW9V3HvVdx7Ffdexb1Xce9V3HsV917FvVdx73Xcex33XlPvLw95uG7ruaptp0_FVTqumuMqE1ctcdUaVc1TXIW4SsRVce_nuPdz3Ps57v0c936Oez_HvTdx703cexP33sS9N3HvTdx7E_fexL033Ptgs4urlimuQlwl4ioZV6m4SsdVc1xl4qq490vc-zXu_Rr3fo17v3LvnVW2qrhKx1VzXGXiqiWuWqOqfb8orEOiTiTq4hHse0FhXTyGfecnrItHse_zhHWJcSAxDiTGgcQ4kBgHEuNAYhxIjAOJcSAxDiTGIRLjEIlxiMQ4RGIcIjEOkRiHSIxDJMYhEuPglVhthiMvxWpzE3ktvtaJRJ1M1KlEnU7UzYk6k6hbEnVrXKcS41CJcajEOFRiHCoxDpUYh0qMQyXGoRLjUIlx6MQ4dGIcOjEOnRiHToxDJ8YRLNK708_jEFvdkqhb47pgod7rkKgTiTqZqFOJOp2omxN1iXHMiXEEK_ZuoE-JOiTqeBzbXkywau91KlGnE3Vzos4k6pZE3RrXBYv3XodEXWIcS2IcS2IcS2IcS2IcS2IcS2IcvIpLZ4SCl_FrHcK6q8-Lj-y0yilwaCf2gGt9Xvapn5ciRnMe9qT2_2xXa24SNTfJmptUzU265qa55iZTc9NSc9NaNbl1KlGlE6hSClRpBarUAlV6gSrFQJVmoEo1UKUboko3RB1fVOmGqNINUaUboko3RJVuiCrdEFW6Iap0Q1bphqzSDVm3mFTphqzSDVmlG7JKN2SVbsgq3ZBVuqGqdENV6Yaq0g1VZ2lU6Yaq0g1VpRuqSjdUlW6oKt3QVbqhq3RDV-mGrtINXWeGVumGrtINXaUbuko3dJVuzFW6MVfpxlylG3OVbsxVujHX-ShVujFX6cZcpRtzlW6YKt0wVbphqnTDVOmGqdINU6Ubps6BrdINU6Ubpko3lirdWKp0Y6nSjaVKN5Yq3ViqdGOp0o2lbnejSjeWKt1Yq3RjrdKNtUo31irdWKt0Y63SjbVKN9Yq3Vjrtr4q977qNr-mut2vqW77a6rb_5rqNsCmuh2wqW4LbKrbA5vqNsGmOi2p3SKt05LKTdLKXdLKbdLKfdLKjdLKndLKrdK6vVLUbZaibrcUddul-yH-q2-r05K6HVPUbZmibs8UdZumqNs1Rd22Ker2Tff4h1ffVqcldVunqNs7Rd3mKep2T1G3fYq6_VPUbaCibgcVdVuoqNtDRd0mKup2UVG3jYq6fVTUbaSibicVdVupqNtLRd1mKup2U1G3nYq6_VTUbaiibkcVdVuqqNtTRd2mKup2VVG3rYq6fVXUbayibmcVdVurqNtbRd3mKup2V1G3vYq6_VXUbbCibocVdVusqNtjRd0mK-p2WVG3zYq6fVbUbbSibqcVdVutqNtrRd1mK-p2W1G33Yq6_VbUbbiibscVdVuuqNhzfWXMJIVA_v63779_-tUBe9gtx5tyf6R72uSeLZcd6XKTqLmJFHPr2xQOcAvrdDeJz-4Sw6J4cQl_gcjP3fq0X73yA7cA0T2tnZP0lutOfXJ_wLOwiXO7PezBPngXrK_P0pH5LB0xZ-nIcpaOrGfpCG_rvnNPcJqeiNP0JCbL9-rJaegVp-FXnIZgcRqGxWkoFqfhWHEajhWn4VhxGo4Vp-FYcRqO3c6syD_g46hXOAim6q6YQ9q4COI0lCBPQwnyNJQgT0MJ8jSUIE9DCfI0Zpc8jdklT2N2ydOYXfI0HKtOw7HqNByrTsOx6jQcq07Dseo0HKtOw7HqNBy7xTX844cvjx8-Pf7y65OrPQ3f6dPwnT4N323xGv_89OXH__P0y7-7OvnSueE4i3I3hcMsXnFX_Ga1cW70aV4UfRpjRJ_m5ZxP83LOp3k559MYI_NpjJH5NMZIEB8UnD2L7QgaQaW75MUZ9Navxw9f78pOgq5tS9UTZvPBk7tBcW8Fgks0X7JR4nwaK2Y-DTnPpyHn-TTkbE5DzuY05GxOQ87mNORsTkPO5jSeojkNx5rTcOwWj0geBocalvsKS8xLbXyF5TQ0s5yGZpbT0MxyGppZTkMzy2loZjkNzSynMeWW05hy62lMufU0HLuehmPXaOttrdp6W8f3TdeY0Nqs7etp-Gk9DT-tp-GnINvGe3flNAwVZAV5766cxg4Mspe8d1dOYwkGWVbeuyun4dogG8x7d-U8bHumzxvOw7Yn-sDhRF84nOgThxN943CijxxO9JXDiT5zwHnY9jwfOuA8XzoEWarKXVyc57sEnOfDhCCb1nt35TzMKM7DjImPN96tK44Z_9fjvz19-O8___lp-6Qy_vZdVn39HiQWe81tt_oCHuf5WgDn-VwA5_leIMi79t5dOc97ep5PBoKcc-_dlfNYMOf5agDn-WwA5_luAOf5cCDINfjeXTkP26rzsO15PljAeb5YwHk-WQhyTL53V87Dtvo8bKvPw7bb1yQvXJztUxB2cfibjFf4KokPKBr5Kuf5IALn-SIC5_kkAuf5JgLn-SgiyJr63l05j6V1ns8bcJ7vG_YstC_IefvY4GUtkrUiIvJENHwjRjZVoVg4Tyg6zhOLjvMEowfZcd-7K-fxPRKx9e_WlfPYH-cJx8d54vFxnoB8nCciH-cJycd5YvJxnqD8PXP1C5tiTdofa2R_XNNKb3aF-Mg9FY9__B__EoxAcRc2k2S3Hy6ssmWdlkI8uHTTSj-4FNJqfnBpofX04PI4y0vNRdOlVA8ukbFYL6XLPEt7_UXMWB5cKl2Yhy2VrbSly-OFethSuUr5sKVSlfYOG-iD9WHLJSrW6WFL5iltpQexYR62MzbKwt5tgxwsoI0xsA-3R_wW0J7au17bU3NcbraH1voybntm7AZ-QVH2uguIxsOWn05YKdhTSnuzPZy0w7JiFLZkUS69sUd-4nKzPXGzo7IHXso-xYJcgO1xj3ueA3nYEiTZe9UVw2712-vsTrtFU9eB2H1miUuv7T6ve4y5NlsQ17zulfo6ErvHZvtlt7iezbWHLRuHUwq7xWNFYndY7AzYDQ4rEbupIS-Adi_DydjuT6jLEOx-glMS68_buZqvo5ndvNhKq2FWKtabmy8ys86Uncv5imNdCWHvXnf5WOvdzrS12N1kmSuMcaOxRXVFNNor8HztuzURhbZFqwIXdGshWQWxBop9_HIdz3JVZ7s6upvt6uSeblcH2xFLzrbHlhulfc71nVmus2PZwMpivaLY70XsvaufHPuhhu2Y_fhithdeJ8d-dCCtOtiofznZh1uxTfaFn9z82PfPBp5v76KN_HavmI28tpPpIp_de2sjj8XsHmJH5a4we3dd6Ov2wtrYUycMF_yp7EMsI9gBu-DHrSivz7CcsHXVsoIbgQt_29AdMWzXO91w19hh2kssOWxdsfTg4C0_PIsAtuuOI9zzhfJiEdo_XxCuuL5gLrrCiciRhStLYlZ55VYXoKAsp8krv7oogY0T9VWL3DH5hmh5Y5OiZQ6x3br64anpOuXurHIbkWWQTZKOQ9zoLIsoV-2p3Z0XudfEHdjsHL1cp1p5WnRHBu4KfaVft2W-jUMT0WvlgRynWHxLKkK5B14wtaterpKzvOIQHbFsZa9GllrcI-YrG7udKrcGzXonSLdTI1ytnUs7JTMJdl59jzaKsXc6knEDsCxjScJtArg7Hc3Y5cO54tsTzZXQnC_qlkNLNNI92s6lJWvnDLm-WrLZlkRLN06Si7w-zvGNWx611wfLOE7dlyuFOnNofxwN0vKOcFqyOibFS4sj80lX9EMWH_7wy9Off_ztz86i-e5qhkX7FrZyM6B0YEAFV4ZWVXJLZN9QkRZTZDA38263AMHD2x-YQlFyt7QuKLfYAOLbXSfxPZt1F2p6SP3Gxj4r28geeUibGbtfsvDILvT9EPxWxgYY9jf8gs6bk2yQBhKblmAQq8s04lF2azV4xDbyTRyh2m2DkKESTtw7ca20n_rTkB4Dk_1jcHWgeHvbFcV-VfvVbrtHTIHvoAI13W5Q1-mj2X_2K-xHcfHjkVD4fUKQGkQxWPAhhmuZBEtgr8Re6YKbm-vHx5SSB5dcTIGH74JfgThS4eA3hz9yH7fZ3N-UR36T-GOD_ftQsNJUC5o_jQ2o5VWq7zaw6VEmIYGdrKagc0Hb8zNYRxd-2C4YwVPiXzu3Y9jsbUqE7L-RvJB4g1q-oMGPKd_8DeWI-aNRB-Hsnd9Jjom_4XoR_NJzSvD7gvv5bRLnLPsf_vjrJafoL65lfg_rxWRAlUyM7IVN85FfHi80-_xcCMI-eR9ZZJ6Z7DPoldvfroXHkp4Lyb3azrtk7u1qM8kcW16-8HFo-b7xt_J1U7Dr9oJzA0UXT8F7ghSo4Jcslf2--H2KhmifqOIlMpDjvkO6SeSRL3nRFpxZcpR501WUY8bL1x184i5s6w7HfO9iCeUYrDTJX--DYTQhAhkkzMRb6HHi6K5YK8JXenuXOda6qVaoqlcu-AHw28kx8YPh3d5s1WddC36lPPmMsBLc4y2fyv4aqMTYEPqybvVKxR2_UT9NH2ktkbbuT1wCmMA931U958S16aPus1ZyEO4bWZeDaMsNheQvqIbexD5u9eEfHRCnNAp2oDhi9Rb2FIeh3nC76SYJy2OFTu43pXKaF7_Um1y3Du2apgKZr4GC6GDcbK7eztcIftAewVv0GExtsJmwW7Sa_4ROfHJQc-JFvt1WGAfW3sJBnvss2YlI2OReR7iehZsj25olnK2RCGhNPzHo8YtJSU56cvszETNSnrVM_JdgOAFTvKSdD-IDz2tECbY37Nse7DOkYkp7vfscRPpqI-1wUGuNacr5qXtvuXBG6jd63KbP6xpEyKamPHqwvav0lSx-yTkwtsOxw9xlueK41shqZq34HAzxE__nzTf7RE6W_OGfn7789n9dTBIHi3bbBLtJyuV47ElrZ7nxcrkUnmhw5GWbOV4SjuftXoUl8eLdgGeC-MdiLl9yL9CL7sz7M-zNNz4SXPq4k5yk9xZbYuuNX6QgoW7xzK9f9RTXnKd4C6Zb-1mFyFuFN0mHy7cf8O4rM-buY0715MWr7DaSXpsHN9j6QmDJvnjw6z6nCM2a7ZIXJL4mBrXvB3zcL3EH-q_7gGJ7yDacXdPC82ZOSPuKo_RE8ti3nuxyEtjbe-VBotfjfiW2VkMJIeizDpTT9VJe9dc9cq5ckOjPPvDP-xy7Jyc2UFvScJDz9K3RAdPXD_NvYKIgFQ8TePkIXk8El0Titm0LC3NXGCSWwhus6EFK0ZviyBvr1CuzgLbl1Nfm_SxeKYI0no2Ig2NzXsHWHIfzYokPnPXwPHcn05S1lTy9CfNiBoObwgUgsH32rlytKRcKNrUjGpE4nbzFmy_iVTH6IQJSsP38PtCeNpkpy7X0lYkmS2wKkV0xk1oq2r8vos95YpCBsYPtUheS86qTtt9vgZZfD_aW7xHuHSSATKK-av_ePfIdo7uD_JHHIa86YzO-eocoyNLY6IWTX7c_b2HScSDOG3fKg5SIb11wXpnT8NXu7aszFZavB69MPNjWGHtlqsGSxYgDcG6x8RUkArzhKUAqy98bT0uCbH2viaNfMlRU7b6qdrGmSAXQNHVbdGH0dpBdrhF167ovIDg-5pa6GsTJ3OKl4wiZm8YahYndgojxIMFbPwvoJvnhYk1LmysczPLWFzQVqnIL45xDVt4Y4pbM0Pa2QO0w01rxyUYyK9rbgi-D7Ga942SDfGZtv86aGxqJ8-09r413OAClH7lw6MnhLsWS0ISdRwK5vDgWWD_8J1ZxsdPSf97wOfsaRybcJgkb335EeyZ7WphayHbU4B1KRsIEGd3eqqOmMNorSJjW_VPPVIq0XrFmQVK0buHyyfxnb6TsIH7ljZ-eLonzhKYGMwe5HCpmELvSMhYwyOX15o9bE8Eot9hVTmXa6vamBOEvb1Wwbovnemvfj8NdGrh01zQcL05gNhrGC0Fc03D89NuXLw8u8cZWFL4ofVH5ovbF2ReNLy6-uBIEwxEeCBCECIIEYYJAQaggWBCuIFzB4yRcQbiCcAXhCsIVhCsIVxCuJFxJuJIFTLiScCXhSsKVhCsJVxKuIlxFuIpwFc8s4SrCVYSrCFcRriJcTbiacDXhasLVrFKEqwlXE64mXE24M-HOhDsT7ky4M-HOrMuEOxPuTLgz4RrCNYRrCNcQriFcQ7iGXyLCNYRrCHch3IVwF8JdCHch3IVwF8Jd-O0l3IVwV8JdCXcl3JVwV8JdCXcl3JVwV6aNgDeYOCZmjompY2LumJg8JmaPieljYv6YmEAm7kFIXdyDgLwC9groK-CvgMACBgsojDkMTGIQAXtyD5jHwEQGZjIwlYG5DExmYDYD0xmYzyADAuceMKWBOQ1MamBWA9MamNfAxAZmNjC1QQVrCPeA2Q1Mb2B-AxMcmOHAFAfmODDJgVkOOljGuAdMdGCmA1MdmOvAZAdmOzDdgfkOTHiYg5WUe8CcByY9MOuBaQ_Me2DiAzMfmPrA3AcTLObcA6Y_MP-BCRDMgGAKBHMgmATBLAimQSyBPcE9YCYEUyGuXOhNsNDeDPagkukyXvgKIuWMiMAMlGyDeg-FzcdLh6-51v74w-PH35zh6bt-t_SorF_I6W7ubeUac-9oo-utH1C7LYD_9suPX764irsd6cpHdiRr9lDGJM_03aKkf25sUXY_N7iB6XrIQuD9sjDF3Xb0FEXYcDwbLah3Y7iVMXzDZWM_had5O6OV3f-47ticDwT2d2nT31LnMn7CvlkfZHXZzzPJfBe_s9mXn0uwJXEtyWurupb0tTRfrzPXuuVaWv2TCcSj2IVoq_U48EB2Cdqu9VB2-VGu6MHg0ezC4y6wy85W69GERxMeza4C220ezWVZd0WbJdsVPZqla-2KHk16NMvRmzQ9mvRjkx5NejTp0Vx-dTcLXpLKo7mfZ5hcmaZMUbWfNfcbDa5o6Irlim1p2I1J--FpP3Xaa4hLrO6Kytf64Vni3S7waqL91GkvzNkPz7Kimw6XVN0V_ehmL8zZo1ku3K71aLNHm70wjUczXpjGj814NOPHZjyaoTfAT53xaMaPbfFo7qcbnNgt_TgBLx5u8XCLn7nFz9zi4dwPOGxPW3159YCWGhzI6oe3erzV461-eKvHWz3e6hXFGr3ba2lt3r1Mb_kkqCyprKhMb_pEr_pkqLxQmbgFhMvs4n7kZSsTLgiXGYYpBoQLwgWNVxCuYFaj8RLTOJNzr9dUP1OZcAXhCsJ1v-qwlQlXEq6UdA0RqiRcSbiWd_brCVeSnIl6QNzjzMG9zDxO4yX2cabgXm-onshc0Xg14WrC1YRrSWhbEzQvIDS_mnA1yVnTeDXhzjS_M8l5JjnPpFczjXfmlYtwZ8IlTnKm2b68Ea4hXOIlZyjtZcIlanJW0vZ8Q3ImdnIm0nb9QrgLyXmh92ghvSKKcsbRXqbxEks5y2gvE-5KuOs2Xv-bDyJwkYLYwxdfZkSBRrt1o9fFPf257JhRXEuX8RjXrK6V-lqaryVzLS3X0notWQ7aih4GHscS0Fb0QPBI8FDwWPBg8GjCowkalEcTHk14NEs6Rs_uH48nPJ7lnHkre0DpAaUHlCRGDyg9oPTDkx5Oejjphyc9mvJoyqMpj6Y8mvJoyqMpj6Y8mvvtmNWVPZz2cNrDWXaRcFdbellW4_4hRfGQjl2wXeJBtR-i9pizx5w95uyHOPshzh5v-2EqV_ZjnD3c7OFmD2c8nPFwxsMZD2c8nPHDM_QmeLTtB6rc-2M8nqWS7bVaPODiARcPuHjAxQMuHnChd88Pb_Fwqx_e6tFWj2YNnZ0GVo9nTR3t5Gltna3Pq0dc6XXn951e-Ine-Ile-Yne-Yle-one-ole-4ne-4le_IlwA6IhXKYa5homG2YbphvmGyYcYhwQ5UAwwxEusQ6Idpyxs5cJl3jHGTt72f2w07oR50TvHoh-IJleJb1-IA4CkRCIhUA0BOIhEBGBmAhERSAugmJmJ1yiIxAfgQjJmTx7mXCJkkCc5EyevUy4mpcUwnWktG6SdEbPsv9H2JaZNmYEcROInEDsBKInED85u2cv06CJoUAUtdk9ewctTe3dsESl9n-srTfv_0m-juCJsGB4QSV4Q_BEWc782cs0bCItEGuBaAvEWyDiwsIrOeEuwbDdj-3t_2AbmzeBwvxIJtjLuUb-Xa2dDeJaCm2dbSW8lv6eTZ2t-HVDZyv-Xdo5W7HIzNmKHu3AxNmKtzRwtuJZ7Jut-MK62YpnMW624gvTZit6tLth8_Dehs1OkoR7aNTs5btJ48qESywUmzNbubs1s5WJkkCcBCIlECuNa8ZsZaIp7DxVs4sTfnOxGTvXL_nuezq2eN_TuRbvezr3PZ37no4rn930ue_p7OX7ns5_7D2dMMRnj6YKfkx3j84PTKc94VbwbXGYisR_cHs3lmzxbixdi682lnZ9vhtLd2Ppbixdy3dj6W4sUbmtsSTuxlJoLO0fKEoOkt7Dfb4a9bMhXUv3czBfvJ-DueJLa0ds_9xPwlzxfhK2l-8WjivfT8Jc-Sy2zV4--0kY9n_-wx-FTcGp17p_cXe3W-52y168x--44t1qccW71XK3Wq6MfLdaXPkev-PKPYwWBImfwszLe4apIJHsnkE2TGG6BGdYn_mPCtJRRylJKdFUokN7GoLwM_fgl10oZ9WDs67aPEk0e5Js9iTV7Em62ZPmZk8yzZ60NHvS2k4zGyp5Oy1HOzVHOz1HO0VHO01HO1VHO11HO2VHO20X7bRdNOT0dtou2mm7aKftop22i3baLtppu2in7aKdtst22i7babtsaMK003bZTttlO22X7bRdttN22U7bZTttV-20XbXTdtVO21VDi72dtqt22q7aabtqp-2qnbardtqu22m7bqftup2263barhs6qO20XbfTdt1O23U7bdfttH1up-1zO22f22n73E7b53baPjfcj2mn7XM7bZ_bafvcTttNO2037bTdtNN2007bTTttN-203TTcfmyn7aadtpt22r600_alnbYv7bR9aaftSzttX9pp-9JO25eGu-3ttH1pp-1rO21f22n72k7b13bavrbT9rWdtq_ttH1tp-1rw8OllqdLDY-XpobnS1PDA6ap4QnT1PCIaWp4xjQ1PGSaGp4yTQ2PmaaGet_0WLWh3rc8WG15stryaLXl2WrLw9WWp6stj1fRUO8bHrCi4QkrGh6xouEZKxoesqLhKSsaHrOi4TkrGh60ouFJKxoetaLhWauLDm31rIZ63_C4FQ3PW9HwwBUNT1zR8MgVDc9c0fDQFQ1PXdHw2BUNz13R8OAVDU9e0fDoFQ3PXtHw8BUNT1_R8PgVDc9f0fAAFg1PYNHwCBYNz2DR8BAWDU9h0fAYFg3PYdHwIBYNT2LR8CgWDc9i0fAwFg1PY9HwOBYNz2PR8EAWDU9k0fBIFg3PZNHwUBYNT2XR8FgWDc9l0fBgFg1PZtHwaBYNz2bR8HAWDU9n0fB4Fg3PZ9HwgBYNT2jR8IgWDc9o0fCQFg1PadHwmBatzml9Sgd3hdw-YXzkP-kk5x8DuODJX4XzX0D--IfHzx_-6emnX59--fCHHx5_-PnLv__86w8__vTh4m087F835q4SRVfJoqtU0VW66Kq56CpTdNVSdNVaJtVC4ZdJH2XiR5n8UTYBKJsBlE0ByuYAZZOAslkQZbMgCt-BslkQZbMgymZBlM2CKJsFUTYLomwWRNksyLJZkGWzIAupqGwWZNksyLJZkGWzIMtmQZbNgiybBVU2C6psFlTZLKjCFaFsFlTZLKiyWVBls6DKZkGVzYIumwVdNgu6bBZ02SzowoW5bBZ02SzoslnQZbOgy2ZhLpuFuWwW5rJZmMtmYS6bhbnQPiqbhblsFuayWZjLZsGUzYIpmwVTNgumbBZM2SyYslkwhWZq2SyYslkwZbOwlM3CUjYLS9ksLGWzsJTNwlI2C0vZLCyF3kLZLCxls7CWzcJaNgtr2SysZbOwls3CWjYLa9ksrGWzsBY6baVeW6HbNhX6bVOh4zYVem5Toes2FfpuU6HzNhV6b1Oh-zYVzkexG104H6WOdKknXepKl_rSpc50qTdd6k4X-tModKhR6FGj0KVGoU-NQqcahV41Ct1qFPrVKHSsUehZo9C1RqFvjULnGoXeNQrdaxT61yh0sFHoYaPQxUahj41CJxuFXjYK3WwU-tkodLRR6Gmj0NVGoa-NQmcbhd42Ct1tFPrbe4RO_rrC-Sh0uVHoc6PQ6Uah141CtxuFfjcKHW8Uet4odL1R6Huj0PlGofeNQvcbhf43Ch1wFHrgKHTBUeiDo9AJR6EXjkI3HIV-OAodcRR64ih0xVHoi6PQGUehN45CdxyF_jgKHXIUeuQodMlR6JOj0ClHoVeOQrccJX75yxPg6NDWngB_9WcZt5unx-Cu7b_1g_zgKp5cxfaLkUvi6Pj645Af_p-7RwSPDM-gt-dtZ9Bb9l4VnE_739t2WFehjNhpMWKn5YidViN2Wo_Y6XnETpsRO72M2Ol1xE5jzCVxyDURQy6KGHJVxJDLIoZcFzHkwoghV0YMuTRiyLVRDLk2iiHXRjHk2iiGXBvFkGujGHJtFEOujWLItVEMuTaKIddGOeTaKIdcG-WQa6Mccm2UQ66Ncsi1UQ65Nsoh10Y55Nooh1wb1ZBroxpybVRDro1qyLVRDbk2qiHXRjXk2qiGXBvVkGujGnJt1EOujXrItVEPuTbqIddGPeTaqIdcG_WQa6Mecm3UQ66Nesi1cR5ybZyHXBvnIdfGeci1cR5ybZyHXBvnIdfGeci1cR5ybZyHXBvNkGujGXJtNEOujWbItdEMuTaaIddGM-TaaIZcG82Qa6MZcm1chlwblyHXxmXItXEZcm1chlwblyHXxmXItXEZcm1chlwblyHXxnXItXEdcm1ch1wb1yHXxnXItXEdcm1ch1wb1yHXxnXItXEdcm3cs7QO1-0hV8c9h-1w3R5yfdwz_A7X7SFXyD3_8XDdHnKN3LNDD9ftMVfJUVPkjLlKDpokZ9AsOYOmyRk0T86giXIGzZQzaKqcMXPlYMxkORgzW87-ew_DdXvMVXLMhDn7j3MM1-0xV8kxc-ZgzKQ5GDNrDsZMm4Mx8-bsv8IzXLfHXCXHTJ2z_2TScN0ec5UcM3sOxkyfgzHz52DMBDoYM4PO_ttow3V7zFVyzCQ6GDOLDsZMo4Mx8-jsvzo4XLfHXCXHTKWDMXPp7L9YOVy3x1wlx0yngzHz6WDMhDoYM6MOxkypgzFz6mDMpDoYM6sOxkyrgzHz6mDMxDoYM7MOxkytgzFz62DM5DoYM7sOxkyvgzHz62DMBDsYM8MOxkyxgzFz7GDMJDsYM8sOxkyzgzHz7GDMRDsYM9MOxky1gzFz7WDMZDsYM9sOxky3gzHz7WDMhDsYM-MOxky5gwFz7vzt4UV_DXdo64KCu0TxlWoK7tMMJaS75NOzPP763Tc0m1s_t5HK7cHbHxOMaGWYfezqxfPtld878XdBEV1QZBcU1QVFd0GZu6CYLihLF5S1z1vZ6eXv8_ajz-uPPu8_-hAA-jAA-lAA-nAA-pAA-rCA6MMCopMN0IcFRB8WEH1YQPRhAdGHBUQfFhB9WED0YQHZhwVkHxaQnVyBPiwg-7CA7MMCsg8LyD4sIPuwgOzDAqoPC6g-LKD6sIDqtCPQhwVUHxZQfVhA9WEB1YcFVB8W0H1YQPdhAd2HBXQfFtCdNgb7sIDuwwK6DwvoPiyg-7DA3IcF5j4sMPdhgbkPC8x9WGDudD7QhwXmPiww92GBuQ8LmD4sYPqwgOnDAqYPC5g-LGD6sIDpdEzYhwVMHxYwfVhg6cMCSx8WWPqwwNKHBZY-LLD0YYGlDwssnaIF-rDA0ocF1j4ssPZhgbUPC6x9WGDtwwJrHxZY-7DA2ocF1k5BQ72ihjqFDU2d4oamToFDU6fIoalT6NDUKXZo6hQ8NHWKHpo6hQ9NnfigWxhhJz7oFUjYK5KwVyhhr1jCXsGEvaIJe4UTohMfdAooRKeIQnQKKQx-PuOmOJ34oFNUITqFFaJTXCE6BRaiU2QhOoUWBj9jcFOcXh8adOKDTuGF6BRfiE4BhugUYYhOIYboFGMY5H-_KU4nPugUZohOcYboFGiITpGG6BRqiE6xhugUbIhO0YboFG6ITvGG6BRwiE4Rh-gUcohOMYfoFHSITlGH6BR2iE5xh-gUeIhOkYfoFHqITrGH6BR8iE7Rh-gUfohO8YfoFICIThGI6BSCiE4xiOgUhIhOUYjoFIaITnGI6BSIiE6RiOgUiohOsYjoFIyITtGI6BSOiE7xiOgUkIhOEYnoFJKITjGJ6BSUiE5RiegUlogecYlFOd-2FHJyDVDdI7cEdfaMYkvv9tNvX748uBxsW1H4ovRF5YvaF2dfNL64-OJKEAxHeCBAECIIEoQJAgWhgmBBuIJwBY-TcAXhCsIVhCsIVxCuIFxBuJJwJeFKFjDhSsKVhCsJVxKuJFxJuIpwFeEqwlU8s4SrCFcRriJcRbiKcDXhasLVhKsJV7NKEa4mXE24mnA14c6EOxPuTLgz4c6EO7MuE-5MuDPhzoRrCNcQriFcQ7iGcA3hGn6JCNcQriHchXAXwl0IdyHchXAXwl0Id-G3l3AXwl0JdyXclXBXwl0JdyXclXBXwl2ZNgLeYOKYmDkmpo6JuWNi8piYPSamj4n5Y2ICmbgHIXVxDwLyCtgroK-AvwICCxgsoDDmMDCJQQTsyT1gHgMTGZjJwFQG5jIwmYHZDExnYD6DDAice8CUBuY0MKmBWQ1Ma2BeAxMbmNnA1AYVrCHcA2Y3ML2B-Q1McGCGA1McmOPAJAdmOehgGeMeMNGBmQ5MdWCuA5MdmO3AdAfmOzDhYQ5WUu4Bcx6Y9MCsB6Y9MO-BiQ_MfGDqA3MfTLCYcw-Y_sD8ByZAMAOCKRDMgWASBLMgmAaxBPYE94CZEEyFuHLh1TzbLLfNxttS6x7ZbNBs-EFx5d262yaARU7juVt3rny37lz5bt258t26u1t3d-vO_XO37u7WXTPrbrO2RLCRJwJLLDTk9t29j-4_s-_83a20u5W2l-9WmivfrTRXvltpdyvN_XO30u5W2t1Kc_-8Zg_Obbc9v-fxcat9jV78vNXHF4abPdTNtItMu8y0q0y7zrTPmXaTaV8y7WtOPlkB5iSInAiRkyFyQkROisiJETk5IidI5CQpcpIUWV3MSVLkJClykhQ5SYqcJEVOkiInSZGTpMxJUuYkKbOvdU6SMidJmZOkzElS5iQpc5KUOUmqnCRVTpIqJ0mVZcicJFVOkionSZWTpMpJUuUkqXOS1DlJ6pwkdU6SOidJnZOkzklS5ySpc5LUOUnOOUnOOUnOOUnOOUnOOUnO2XU7J8k5J8k5J8k5J0mTk6TJSdLkJGlykjQ5SZqcJE3WBMpJ0uQkaXKSXHKSXHKSXHKSXHKSXHKSXHKSXHKSXLLWZE6SS06Sa06Sa06Sa06Sa06Sa06Sa06Sa06Sa06Sa9Ywz1vmWdN8ytrmU9Y4n7LW-ZQTZ5goLn1F1kCfshb6lDXRp6xMC9ydrEzzDk_e48m7PHmfJ-_05L2evNuT9XuQdXyQ9XyQdX2Q9X2QdX6Q9X6QdX-Q9X-QdYCQ9YCQdYGQ9YGQdYKQ9YLC1DHpK7IyzTpCyHpCyLpCyPpCyDpDyHpDyLpDyPpDyDpEyHpEyLpEyPpEyDpFyHpFyLpFyPpFyDpGyHpGyLpGyPpGyDpHyHpHyLpHyPpHyDpIyHpIyLpIyPpIyDpJyHpJyLpJyPpJyDpKyHpKyLpKyPpKyDpLyHpLyLpLyPpLyDpMyHpMyLpMyPpMyDpNyHpNyLpNyPpNyDpOyHpOyLpOyPpOyDpPyHpPyLpPOPaf_va3b_72_wF9Cvub:1rAvms:MiQXOvrzoLdZNXSgoqngKKvOFiyJBOxiuZoFR1cswMU','2023-12-20 17:34:18.344425'),('n3ckjrtqjk9s7izgdo8ahm2ctn413if1','.eJxVjEEOwiAQRe_C2hCYhtJx6d4zkJmBStVAUtqV8e5K0oUu_38v76UC7VsOe0trWKI6K6tOvx-TPFLpIN6p3KqWWrZ1Yd0VfdCmrzWm5-Vw_wKZWu5Zi97NIhiRWCIYlyAaMGmahAYx7rvJw4xAjAOxs8k5O4IH4JE8qvcH7Wo3ww:1rAGlY:AuiLsF1yg0k9bFOQAJD_LSTUM54OyMm1au7d_0kiF7Q','2023-12-18 21:46:12.559918'),('p9bkmjumhs8nf5y8ta27naebyrmvap2m','.eJxVjUsOgzAMRO-SdRUlRk5Il91zBuQ4ptAPSHwWFeLuDSqV2t2M5-l5VTUtc1svk4x1l9RZWXX6vUXiu_T7kG7UXwfNQz-PXdQ7oo910tWQ5HE52D9BS1O7a23w2DCHFChyAoMCyYCRsmQq2GDu5KEJQDEUFNEKonXgAaIjH7L0JTRW-XvWrf_l-QnqS-UI6Jzatu0NmQJI3A:1rDtMX:u4J8xutFG-RRlQjbJN5H2Vc5JffclKVWKCrRaxBUXEk','2023-12-28 21:35:21.139815'),('zktx8e8uv85bak5pmqe02roun5aol2d1','.eJxVjEEOwiAQRe_C2hCYhtJx6d4zkJmBStVAUtqV8e5K0oUu_38v76UC7VsOe0trWKI6K6tOvx-TPFLpIN6p3KqWWrZ1Yd0VfdCmrzWm5-Vw_wKZWu5Zi97NIhiRWCIYlyAaMGmahAYx7rvJw4xAjAOxs8k5O4IH4JE8qvcH7Wo3ww:1rAc2X:gOfFz-lihXUQb4gpKvDmAkfWnFjG7AdMGX37recXdFQ','2023-12-19 20:29:09.625866');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-15  4:36:53
